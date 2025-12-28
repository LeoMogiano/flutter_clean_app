import 'dart:async';
import 'dart:isolate';

typedef IsolateTaskFn<T, R> = R Function(T param);

class IsolateService {
  IsolateService({this.maxConcurrent = 2});

  final int maxConcurrent;
  final List<_QueuedTaskBase> _queue = [];
  final Map<String, _RunningTask> _running = {};

  Future<R> run<T, R>({
    required String taskId,
    required T param,
    required IsolateTaskFn<T, R> task,
  }) {
    final completer = Completer<R>();
    final queuedTask = _QueuedTask<T, R>(
      taskId: taskId,
      param: param,
      task: task,
      completer: completer,
    );

    _queue.add(queuedTask);
    _tryRunNext();
    return completer.future;
  }

  void cancel(String taskId) {
    _queue.removeWhere((t) => t.taskId == taskId);

    final running = _running.remove(taskId);
    if (running == null) return;

    running.isolate.kill(priority: Isolate.immediate);
    running.receivePort.close();
    if (!running.completer.isCompleted) {
      running.completer.completeError(CancellationException('Task $taskId cancelled'));
    }
    _tryRunNext();
  }

  void cancelAll() {
    _queue.clear();
    for (final running in _running.values) {
      running.isolate.kill(priority: Isolate.immediate);
      running.receivePort.close();
      if (!running.completer.isCompleted) {
        running.completer.completeError(CancellationException('All tasks cancelled'));
      }
    }
    _running.clear();
  }

  void _tryRunNext() {
    while (_running.length < maxConcurrent && _queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      unawaited(task.spawn(this));
    }
  }

  Future<void> _spawn<T, R>(_QueuedTask<T, R> task) async {
    final receivePort = ReceivePort();

    try {
      final isolate = await Isolate.spawn<_IsolateMessage<T, R>>(
        _entryPoint,
        _IsolateMessage<T, R>(
          param: task.param,
          task: task.task,
          sendPort: receivePort.sendPort,
        ),
      );

      _running[task.taskId] = _RunningTask(
        isolate: isolate,
        receivePort: receivePort,
        completer: task.completer,
      );

      unawaited(
        receivePort.first
            .then((message) {
              final running = _running.remove(task.taskId);
              if (running == null || running.completer.isCompleted) return;
              if (message is Exception) {
                running.completer.completeError(message);
              } else {
                running.completer.complete(message as R);
              }
              running.receivePort.close();
            })
            .whenComplete(_tryRunNext),
      );
    } catch (e) {
      receivePort.close();
      if (!task.completer.isCompleted) {
        task.completer.completeError(e);
      }
      _tryRunNext();
    }
  }

  static void _entryPoint<T, R>(_IsolateMessage<T, R> message) {
    try {
      final result = message.task(message.param);
      message.sendPort.send(result);
    } on Exception catch (e, stack) {
      message.sendPort.send(Exception('$e\n$stack'));
    }
  }
}

// ===================== INTERNAL TYPES =====================

abstract class _QueuedTaskBase {
  String get taskId;
  Future<void> spawn(IsolateService service);
}

class _QueuedTask<T, R> implements _QueuedTaskBase {
  _QueuedTask({
    required this.taskId,
    required this.param,
    required this.task,
    required this.completer,
  });

  @override
  final String taskId;
  final T param;
  final IsolateTaskFn<T, R> task;
  final Completer<R> completer;

  @override
  Future<void> spawn(IsolateService service) {
    return service._spawn<T, R>(this);
  }
}

class _RunningTask {
  _RunningTask({
    required this.isolate,
    required this.receivePort,
    required this.completer,
  });

  final Isolate isolate;
  final ReceivePort receivePort;
  final Completer<Object?> completer;
}

class _IsolateMessage<T, R> {
  _IsolateMessage({
    required this.param,
    required this.task,
    required this.sendPort,
  });

  final T param;
  final IsolateTaskFn<T, R> task;
  final SendPort sendPort;
}

class CancellationException implements Exception {
  CancellationException(this.message);
  final String message;
  @override
  String toString() => 'CancellationException: $message';
}
