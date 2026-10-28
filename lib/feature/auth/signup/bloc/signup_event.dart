part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

final class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class SignupCodeChanged extends SignupEvent {
  const SignupCodeChanged(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

final class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

final class SignupPasswordConfirmChanged extends SignupEvent {
  const SignupPasswordConfirmChanged(this.passwordConfirm);

  final String passwordConfirm;

  @override
  List<Object?> get props => [passwordConfirm];
}

final class SignupTermsToggled extends SignupEvent {
  const SignupTermsToggled();
}

/// "인증코드 발송" 버튼
final class SignupCodeRequested extends SignupEvent {
  const SignupCodeRequested();
}

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
