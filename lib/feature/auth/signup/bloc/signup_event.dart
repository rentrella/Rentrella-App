part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

final class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
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

final class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
