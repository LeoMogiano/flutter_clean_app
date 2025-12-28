import 'package:logger/logger.dart';

class LoggerService {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
    ),
  );

  void d(String message) => _logger.d(message);
  void i(String message) => _logger.i(message);
  void w(String message) => _logger.w(message);
  void e(String message) => _logger.e(message);
  void s(String message) => _logger.log(Level.info, '✅ $message');
}
