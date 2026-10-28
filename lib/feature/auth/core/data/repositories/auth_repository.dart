import 'package:rentrella/core/network/api_exception.dart';

/// 인증 관련 서버 통신 인터페이스
///
/// 실패 시 [ApiException]을 던진다. 구현체: [ApiAuthRepository], [MockAuthRepository]
abstract interface class AuthRepository {
  /// 저장된 로그인(로그인 유지) 토큰이 있는지
  Future<bool> hasSession();

  Future<void> login({
    required String email,
    required String password,
    required bool keepLoggedIn,
  });

  /// 회원가입용 이메일 인증코드 발송
  Future<void> sendSignupCode({required String email});

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String verificationCode,
  });

  /// 비밀번호 재설정용 인증코드 발송
  Future<void> sendVerificationCode({required String email});

  /// 인증코드 일치 여부
  Future<bool> verifyCode({required String email, required String code});

  Future<void> changePassword({
    required String email,
    required String code,
    required String password,
  });

  Future<void> logout();
}

class AuthException extends ApiException {
  const AuthException(super.message);

  @override
  String toString() => 'AuthException: $message';
}
