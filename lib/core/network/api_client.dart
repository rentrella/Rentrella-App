import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rentrella/core/network/api_config.dart';
import 'package:rentrella/core/network/auth_interceptor.dart';
import 'package:rentrella/core/network/token_storage.dart';

/// 서버 통신용 [Dio]를 만든다.
///
/// [onSessionExpired]: 토큰 재발급까지 실패했을 때 (로그인 화면 이동 등)
Dio createApiClient({
  required TokenStorage tokenStorage,
  String baseUrl = ApiConfig.baseUrl,
  VoidCallback? onSessionExpired,
  HttpClientAdapter? adapter,
}) {
  final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: ApiConfig.timeout,
    receiveTimeout: ApiConfig.timeout,
    contentType: Headers.jsonContentType,
  );

  final plainDio = Dio(options);
  final dio = Dio(options);
  if (adapter != null) {
    plainDio.httpClientAdapter = adapter;
    dio.httpClientAdapter = adapter;
  }

  dio.interceptors.add(
    AuthInterceptor(
      plainDio: plainDio,
      tokenStorage: tokenStorage,
      onSessionExpired: onSessionExpired,
    ),
  );
  return dio;
}
