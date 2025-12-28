import 'package:dio/dio.dart';
import 'package:my_app/core/error/error_translations.dart';

class Failure implements Exception {
  Failure({
    required this.code,
    this.message,
    this.statusCode,
    this.type = FailureType.unknown,
    this.domain,
  });
  final String code;
  final String? message;
  final int? statusCode;
  final FailureType type;
  final String? domain;
}

enum FailureType {
  network,
  server,
  timeout,
  unauthorized,
  badRequest,
  unknown,
}

Failure mapDioErrorToFailure(DioException error, {String? domain}) {
  final backendFailure = _mapBackendMessageToFailure(error, domain: domain);
  if (backendFailure != null) return backendFailure;

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return Failure(
        code: 'timeout_connection',
        message: 'Timeout de conexión',
        type: FailureType.timeout,
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.sendTimeout:
      return Failure(
        code: 'timeout_send',
        message: 'Timeout al enviar datos',
        type: FailureType.timeout,
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.receiveTimeout:
      return Failure(
        code: 'timeout_receive',
        message: 'Timeout al recibir datos',
        type: FailureType.timeout,
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.badCertificate:
      return Failure(
        code: 'bad_certificate',
        message: 'Certificado inválido',
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.badResponse:
      return Failure(
        code: 'bad_response',
        message: 'Error del servidor',
        type: FailureType.server,
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.cancel:
      return Failure(
        code: 'request_cancelled',
        message: 'Solicitud cancelada',
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.connectionError:
      return Failure(
        code: 'connection_error',
        message: 'Error de conexión',
        type: FailureType.network,
        statusCode: error.response?.statusCode,
        domain: domain,
      );
    case DioExceptionType.unknown:
      return Failure(
        code: 'unknown_error',
        message: 'Error desconocido',
        statusCode: error.response?.statusCode,
        domain: domain,
      );
  }
}

Failure? _mapBackendMessageToFailure(DioException error, {String? domain}) {
  final data = error.response?.data;
  if (data is! Map) return null;
  final message = data['message'];
  if (message is! String) return null;
  final translated = backendErrorTranslations[message];
  if (translated == null) return null;
  return Failure(
    code: 'backend_message',
    message: translated,
    statusCode: error.response?.statusCode,
    domain: domain,
  );
}
