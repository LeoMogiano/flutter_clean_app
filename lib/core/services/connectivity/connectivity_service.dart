import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity() {
    _init();
  }

  final Connectivity _connectivity;
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  void _init() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      _handleConnectivityChange,
      onError: (Object error) {
        _controller.addError(error);
      },
      cancelOnError: false,
    );
  }

  void _handleConnectivityChange(List<ConnectivityResult> results) {
    final isConnected = _hasConnection(results);
    _controller.add(isConnected);
  }

  bool _hasConnection(List<ConnectivityResult> results) {
    return results.any(
      (result) => result != ConnectivityResult.none && result != ConnectivityResult.bluetooth,
    );
  }

  /// Stream de cambios de conectividad
  Stream<bool> get onStatusChange => _controller.stream;

  /// Verifica conectividad actual
  Future<bool> get isConnected async {
    try {
      final results = await _connectivity.checkConnectivity();
      return _hasConnection(results);
    } on Exception catch (_) {
      return false;
    }
  }

  /// Limpieza de recursos
  Future<void> dispose() async {
    await _subscription?.cancel();
    await _controller.close();
  }
}
