import 'package:dio/dio.dart';
import 'package:my_app/bootstrap/injection.dart';
import 'package:my_app/core/services/logger_service.dart';

class GlobalInterceptor extends Interceptor {
  final LoggerService _logger = sl<LoggerService>();

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _logger
      ..s(
        'Response: [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.uri}',
      )
      ..d('Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger
      ..e(
        'Error: [${err.response?.statusCode}] ${err.requestOptions.method} ${err.requestOptions.uri}',
      )
      ..w('Message: ${err.message}');
    super.onError(err, handler);
  }
}
