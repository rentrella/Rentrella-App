part of 'password_change_bloc.dart';

sealed class PasswordChangeEvent extends Equatable {
  const PasswordChangeEvent();

  @override
  List<Object?> get props => [];
}

final class PasswordChangeEmailChanged extends PasswordChangeEvent {
  const PasswordChangeEmailChanged(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

final class PasswordChangeCodeChanged extends PasswordChangeEvent {
  const PasswordChangeCodeChanged(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

final class PasswordChangePasswordChanged extends PasswordChangeEvent {
  const PasswordChangePasswordChanged(this.password);

  final String password;

  @override
  List<Object?> get props => [password];
}

final class PasswordChangePasswordConfirmChanged extends PasswordChangeEvent {
  const PasswordChangePasswordConfirmChanged(this.passwordConfirm);

  final String passwordConfirm;

  @override
  List<Object?> get props => [passwordConfirm];
}

/// "인증코드 발송" 버튼
final class PasswordChangeCodeRequested extends PasswordChangeEvent {
  const PasswordChangeCodeRequested();
}

/// 인증코드 "확인" 버튼
final class PasswordChangeCodeVerified extends PasswordChangeEvent {
  const PasswordChangeCodeVerified();
}

final class PasswordChangeSubmitted extends PasswordChangeEvent {
  const PasswordChangeSubmitted();
}
