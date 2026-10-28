import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

/// 서버 없이 사용하는 목 구현체 (`--dart-define=USE_MOCK=true`, 테스트)
class MockAuthRepository implements AuthRepository {
  /// 목 인증코드
  static const mockCode = '123456';

  @override
  Future<bool> hasSession() async => false;

  @override
  Future<void> login({
    required String email,
    required String password,
    required bool keepLoggedIn,
  }) async {}

  @override
  Future<void> sendSignupCode({required String email}) async {}

  @override
  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String verificationCode,
  }) async {
    if (verificationCode != mockCode) throw const AuthException('인증코드 불일치');
  }

  @override
  Future<void> sendVerificationCode({required String email}) async {}

  @override
  Future<bool> verifyCode({
    required String email,
    required String code,
  }) async => code == mockCode;

  @override
  Future<void> changePassword({
    required String email,
    required String code,
    required String password,
  }) async {
    if (code != mockCode) throw const AuthException('인증코드 불일치');
  }

  @override
  Future<void> logout() async {}
}
