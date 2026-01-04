import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerService {
  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0),
  );

  void _log(void Function() logFn) {
    if (kDebugMode) logFn();
  }

  void d(String message) => _log(() => _logger.d(message));
  void i(String message) => _log(() => _logger.i(message));
  void w(String message) => _log(() => _logger.w(message));
  void e(String message) => _log(() => _logger.e(message));
  void s(String message) => _log(() => _logger.log(Level.info, '✅ $message'));
}
