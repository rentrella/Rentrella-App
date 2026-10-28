import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rentrella/core/network/token_storage.dart';

/// Authorization 헤더를 붙이고, 401이면 `/auth/reissue`로 한 번 재발급 후 재시도한다.
/// 재발급에 실패하면 토큰을 지우고 [onSessionExpired]를 호출한다.
///
/// 재발급·재시도는 이 인터셉터가 없는 [_plainDio]로 보낸다.
/// (QueuedInterceptor 안에서 같은 Dio를 다시 타면 onError 큐가 서로를 기다려 멈춘다.)
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required this._plainDio,
    required this._tokenStorage,
    this._onSessionExpired,
  });

  final Dio _plainDio;
  final TokenStorage _tokenStorage;
  final VoidCallback? _onSessionExpired;

  /// 로그인·회원가입 등 `/auth/*`는 토큰 없이 호출하고 401도 그대로 전달한다.
  static bool _isAuthPath(String path) => path.startsWith('/auth/');

  static String _bearer(String token) => 'Bearer $token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!_isAuthPath(options.path)) {
      final tokens = await _tokenStorage.read();
      if (tokens != null) {
        options.headers['Authorization'] = _bearer(tokens.accessToken);
      }
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    if (err.response?.statusCode != 401 || _isAuthPath(request.path)) {
      return handler.next(err);
    }

    var tokens = await _tokenStorage.read();
    if (tokens == null) {
      await _expire();
      return handler.next(err);
    }

    // 큐에서 기다리는 동안 앞선 요청이 이미 재발급했다면 새 토큰으로 재시도만 한다.
    if (request.headers['Authorization'] == _bearer(tokens.accessToken)) {
      try {
        final res = await _plainDio.post<Map<String, dynamic>>(
          '/auth/reissue',
          data: {'refreshToken': tokens.refreshToken},
        );
        tokens = AuthTokens.fromJson(res.data!);
        await _tokenStorage.save(tokens);
      } on DioException {
        await _expire();
        return handler.next(err);
      }
    }

    request.headers['Authorization'] = _bearer(tokens.accessToken);
    try {
      handler.resolve(await _plainDio.fetch(request));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) await _expire();
      handler.next(e);
    }
  }

  Future<void> _expire() async {
    await _tokenStorage.clear();
    _onSessionExpired?.call();
  }
}
