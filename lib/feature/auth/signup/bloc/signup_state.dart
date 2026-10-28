part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState({
    this.name = '',
    this.email = '',
    this.code = '',
    this.password = '',
    this.passwordConfirm = '',
    this.codeSent = false,
    this.agreed = false,
    this.nameError,
    this.emailError,
    this.codeError,
    this.passwordError,
    this.passwordConfirmError,
    this.bannerError,
    this.status = FormStatus.initial,
  });

  final String name;
  final String email;

  /// 이메일 인증코드
  final String code;
  final String password;
  final String passwordConfirm;

  final bool codeSent;

  /// 개인정보 수집 및 이용 동의 여부
  final bool agreed;

  final String? nameError;
  final String? emailError;
  final String? codeError;
  final String? passwordError;
  final String? passwordConfirmError;
  final String? bannerError;

  final FormStatus status;

  SignupState copyWith({
    String? name,
    String? email,
    String? code,
    String? password,
    String? passwordConfirm,
    bool? codeSent,
    bool? agreed,
    ValueGetter<String?>? nameError,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? codeError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? passwordConfirmError,
    ValueGetter<String?>? bannerError,
    FormStatus? status,
  }) => SignupState(
    name: name ?? this.name,
    email: email ?? this.email,
    code: code ?? this.code,
    password: password ?? this.password,
    passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    codeSent: codeSent ?? this.codeSent,
    agreed: agreed ?? this.agreed,
    nameError: nameError != null ? nameError() : this.nameError,
    emailError: emailError != null ? emailError() : this.emailError,
    codeError: codeError != null ? codeError() : this.codeError,
    passwordError: passwordError != null ? passwordError() : this.passwordError,
    passwordConfirmError: passwordConfirmError != null
        ? passwordConfirmError()
        : this.passwordConfirmError,
    bannerError: bannerError != null ? bannerError() : this.bannerError,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    name,
    email,
    code,
    password,
    passwordConfirm,
    codeSent,
    agreed,
    nameError,
    emailError,
    codeError,
    passwordError,
    passwordConfirmError,
    bannerError,
    status,
  ];
}
