import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:my_app/bootstrap/app_config.dart';
import 'package:my_app/core/error/failure.dart';
import 'package:my_app/core/network/interceptors/global_interceptor.dart';

class ApiClient {
  ApiClient({
    Dio? dio,
    String? baseUrl,
    List<Interceptor>? interceptors,
  }) : dio =
           dio ??
           Dio(
             BaseOptions(
               baseUrl: baseUrl ?? AppConfig.apiBaseUrl,
               connectTimeout: const Duration(seconds: 10),
               receiveTimeout: const Duration(seconds: 10),

             ),
           ) {
    for (final interceptor in _globalInterceptors) {
      if (!this.dio.interceptors.any((i) => i.runtimeType == interceptor.runtimeType)) {
        this.dio.interceptors.add(interceptor);
      }
    }

    if (interceptors != null) {
      for (final interceptor in interceptors) {
        if (!this.dio.interceptors.any((i) => i.runtimeType == interceptor.runtimeType)) {
          this.dio.interceptors.add(interceptor);
        }
      }
    }
  }

  static final List<Interceptor> _globalInterceptors = [
    GlobalInterceptor(),
    FailureInterceptor(),
  ];

  static void addGlobalInterceptor(Interceptor interceptor) {
    if (!_globalInterceptors.any((i) => i.runtimeType == interceptor.runtimeType)) {
      _globalInterceptors.add(interceptor);
    }
  }

  final Dio dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}

class FailureInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = mapDioErrorToFailure(err);
    dev.log('❌ Failure: ${failure.message}', name: 'NETWORK');
    super.onError(err, handler);
  }
}
