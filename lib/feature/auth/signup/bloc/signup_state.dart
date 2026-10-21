part of 'signup_bloc.dart';

final class SignupState extends Equatable {
  const SignupState({
    this.email = '',
    this.password = '',
    this.passwordConfirm = '',
    this.agreed = false,
    this.emailError,
    this.passwordError,
    this.passwordConfirmError,
    this.bannerError,
    this.status = FormStatus.initial,
  });

  final String email;
  final String password;
  final String passwordConfirm;

  /// 개인정보 수집 및 이용 동의 여부
  final bool agreed;

  final String? emailError;
  final String? passwordError;
  final String? passwordConfirmError;
  final String? bannerError;

  final FormStatus status;

  SignupState copyWith({
    String? email,
    String? password,
    String? passwordConfirm,
    bool? agreed,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? passwordConfirmError,
    ValueGetter<String?>? bannerError,
    FormStatus? status,
  }) => SignupState(
    email: email ?? this.email,
    password: password ?? this.password,
    passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    agreed: agreed ?? this.agreed,
    emailError: emailError != null ? emailError() : this.emailError,
    passwordError: passwordError != null ? passwordError() : this.passwordError,
    passwordConfirmError: passwordConfirmError != null
        ? passwordConfirmError()
        : this.passwordConfirmError,
    bannerError: bannerError != null ? bannerError() : this.bannerError,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    email,
    password,
    passwordConfirm,
    agreed,
    emailError,
    passwordError,
    passwordConfirmError,
    bannerError,
    status,
  ];
}
