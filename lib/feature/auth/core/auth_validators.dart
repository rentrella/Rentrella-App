class AuthValidators {
  static bool email(String value) =>
      RegExp(r'^s\d{5}@gsm\.hs\.kr$').hasMatch(value);

  /// 서버 기준 필수 · 50자 이하
  static bool name(String value) =>
      value.trim().isNotEmpty && value.trim().length <= 50;

  static bool password(String value) => RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+\-=]{8,20}$',
  ).hasMatch(value);
}

class AuthErrors {
  static const email = '이메일은 "sXXXX@gsm.hs.kr" 형식을 따라야 합니다.';
  static const password = '비밀번호는 8-20자 내의 영문+숫자-특수문자 형식을 따라야 합니다.';
  static const passwordConfirm = '비밀번호가 일치하지 않습니다.';
  static const code = '인증 번호가 일치하지 않습니다.';
  static const codeRequired = '인증코드를 입력해 주세요.';
  static const name = '이름을 입력해 주세요. (50자 이하)';
  static const terms = '개인정보 수집 및 이용에 동의해 주세요.';

  /// 하단 에러 배너 메시지
  static const emailBanner = '이메일이 올바르지 않습니다.';
  static const passwordBanner = '비밀번호가 올바르지 않습니다.';

  /// 이메일 → 비밀번호 순으로 첫 번째 오류에 해당하는 배너 메시지
  static String? banner({required bool email, required bool password}) =>
      !email ? emailBanner : (!password ? passwordBanner : null);
}
