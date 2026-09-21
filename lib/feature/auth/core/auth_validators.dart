class AuthValidators {
  static bool email(String value) =>
      RegExp(r'^s\d{5}@gsm\.hs\.kr$').hasMatch(value);

  static bool password(String value) => RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+\-=]{6,20}$',
  ).hasMatch(value);
}

class AuthErrors {
  static const email = '이메일은 "sXXXX@gsm.hs.kr" 형식을 따라야 합니다.';
  static const password = '비밀번호는 6-20자 내의 영문+숫자-특수문자 형식을 따라야 합니다.';
  static const passwordConfirm = '비밀번호가 일치하지 않습니다.';
  static const code = '인증 번호가 일치하지 않습니다.';
}
