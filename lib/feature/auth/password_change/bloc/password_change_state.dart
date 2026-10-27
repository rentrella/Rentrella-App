part of 'password_change_bloc.dart';

final class PasswordChangeState extends Equatable {
  const PasswordChangeState({
    this.email = '',
    this.code = '',
    this.password = '',
    this.passwordConfirm = '',
    this.codeSent = false,
    this.codeVerified = false,
    this.emailError,
    this.codeError,
    this.passwordError,
    this.passwordConfirmError,
    this.bannerError,
    this.status = FormStatus.initial,
  });

  final String email;
  final String code;
  final String password;
  final String passwordConfirm;

  final bool codeSent;
  final bool codeVerified;

  final String? emailError;
  final String? codeError;
  final String? passwordError;
  final String? passwordConfirmError;
  final String? bannerError;

  final FormStatus status;

  PasswordChangeState copyWith({
    String? email,
    String? code,
    String? password,
    String? passwordConfirm,
    bool? codeSent,
    bool? codeVerified,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? codeError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? passwordConfirmError,
    ValueGetter<String?>? bannerError,
    FormStatus? status,
  }) => PasswordChangeState(
    email: email ?? this.email,
    code: code ?? this.code,
    password: password ?? this.password,
    passwordConfirm: passwordConfirm ?? this.passwordConfirm,
    codeSent: codeSent ?? this.codeSent,
    codeVerified: codeVerified ?? this.codeVerified,
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
    email,
    code,
    password,
    passwordConfirm,
    codeSent,
    codeVerified,
    emailError,
    codeError,
    passwordError,
    passwordConfirmError,
    bannerError,
    status,
  ];
}
