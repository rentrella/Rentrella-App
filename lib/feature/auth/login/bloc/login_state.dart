part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.keepLoggedIn = false,
    this.emailError,
    this.passwordError,
    this.bannerError,
    this.status = FormStatus.initial,
  });

  final String email;
  final String password;
  final bool keepLoggedIn;

  final String? emailError;
  final String? passwordError;

  /// 하단 에러 배너 메시지
  final String? bannerError;

  final FormStatus status;

  LoginState copyWith({
    String? email,
    String? password,
    bool? keepLoggedIn,
    ValueGetter<String?>? emailError,
    ValueGetter<String?>? passwordError,
    ValueGetter<String?>? bannerError,
    FormStatus? status,
  }) => LoginState(
    email: email ?? this.email,
    password: password ?? this.password,
    keepLoggedIn: keepLoggedIn ?? this.keepLoggedIn,
    emailError: emailError != null ? emailError() : this.emailError,
    passwordError: passwordError != null ? passwordError() : this.passwordError,
    bannerError: bannerError != null ? bannerError() : this.bannerError,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [
    email,
    password,
    keepLoggedIn,
    emailError,
    passwordError,
    bannerError,
    status,
  ];
}
