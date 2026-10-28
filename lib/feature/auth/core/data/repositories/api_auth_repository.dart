import 'package:dio/dio.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/core/network/token_storage.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

/// rentrella/backend `/auth/*` 연동 구현체
class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({required this._dio, required this._tokenStorage});

  final Dio _dio;
  final TokenStorage _tokenStorage;

  @override
  Future<bool> hasSession() async => await _tokenStorage.read() != null;

  @override
  Future<void> login({
    required String email,
    required String password,
    required bool keepLoggedIn,
  }) => guardApi(() async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    await _tokenStorage.save(
      AuthTokens.fromJson(res.data!),
      persist: keepLoggedIn,
    );
  });

  @override
  Future<void> sendSignupCode({required String email}) => guardApi(
    () => _dio.post('/auth/email/signup-code', data: {'email': email}),
  );

  @override
  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String verificationCode,
  }) => guardApi(
    () => _dio.post(
      '/auth/signup',
      data: {
        'email': email,
        'password': password,
        'name': name,
        'verificationCode': verificationCode,
      },
    ),
  );

  @override
  Future<void> sendVerificationCode({required String email}) => guardApi(
    () => _dio.post('/auth/email/password-reset-code', data: {'email': email}),
  );

  /// 서버에 코드 확인 API가 없어 형식만 확인하고, 실제 검증은 [changePassword]에서 서버가 한다.
  @override
  Future<bool> verifyCode({
    required String email,
    required String code,
  }) async => code.isNotEmpty;

  @override
  Future<void> changePassword({
    required String email,
    required String code,
    required String password,
  }) => guardApi(
    () => _dio.post(
      '/auth/password/reset',
      data: {'email': email, 'verificationCode': code, 'newPassword': password},
    ),
  );

  /// 서버 로그아웃이 실패해도 기기 토큰은 지운다.
  @override
  Future<void> logout() async {
    final tokens = await _tokenStorage.read();
    try {
      if (tokens != null) {
        await _dio.post(
          '/auth/logout',
          data: {'refreshToken': tokens.refreshToken},
        );
      }
    } on DioException {
      // 이미 만료된 토큰 등 — 무시
    } finally {
      await _tokenStorage.clear();
    }
  }
}
