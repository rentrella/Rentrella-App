/// 인증 관련 서버 통신 인터페이스
///
/// 현재는 [MockAuthRepository]를 사용하며, 서버 연동 시 구현체만 교체한다.
abstract interface class AuthRepository {
  /// 로그인. 실패 시 [AuthException]을 던진다.
  Future<void> login({
    required String email,
    required String password,
    required bool keepLoggedIn,
  });

  Future<void> signup({required String email, required String password});

  /// 비밀번호 변경용 인증코드 발송
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

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
