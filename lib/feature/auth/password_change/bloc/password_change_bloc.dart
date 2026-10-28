import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

part 'password_change_event.dart';
part 'password_change_state.dart';

class PasswordChangeBloc
    extends Bloc<PasswordChangeEvent, PasswordChangeState> {
  PasswordChangeBloc({required this._authRepository})
    : super(const PasswordChangeState()) {
    on<PasswordChangeEmailChanged>(
      (e, emit) => emit(state.copyWith(email: e.email)),
    );
    on<PasswordChangeCodeChanged>(
      (e, emit) => emit(state.copyWith(code: e.code, codeVerified: false)),
    );
    on<PasswordChangePasswordChanged>(
      (e, emit) => emit(state.copyWith(password: e.password)),
    );
    on<PasswordChangePasswordConfirmChanged>(
      (e, emit) => emit(state.copyWith(passwordConfirm: e.passwordConfirm)),
    );
    on<PasswordChangeCodeRequested>(_onCodeRequested);
    on<PasswordChangeCodeVerified>(_onCodeVerified);
    on<PasswordChangeSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onCodeRequested(
    PasswordChangeCodeRequested event,
    Emitter<PasswordChangeState> emit,
  ) async {
    final email = state.email.trim();
    if (!AuthValidators.email(email)) {
      emit(state.copyWith(emailError: () => AuthErrors.email));
      return;
    }

    emit(state.copyWith(emailError: () => null, bannerError: () => null));
    try {
      await _authRepository.sendVerificationCode(email: email);
      emit(state.copyWith(codeSent: true));
    } on ApiException catch (e) {
      emit(state.copyWith(bannerError: () => e.message));
    }
  }

  Future<void> _onCodeVerified(
    PasswordChangeCodeVerified event,
    Emitter<PasswordChangeState> emit,
  ) async {
    final verified = await _verify();
    emit(
      state.copyWith(
        codeVerified: verified,
        codeError: () => verified ? null : AuthErrors.code,
      ),
    );
  }

  Future<void> _onSubmitted(
    PasswordChangeSubmitted event,
    Emitter<PasswordChangeState> emit,
  ) async {
    if (state.status.isSubmitting) return;

    final email = state.email.trim();
    final emV = AuthValidators.email(email);
    final codeV = state.codeVerified || await _verify();
    final pwV = AuthValidators.password(state.password);
    final pw2V = state.password == state.passwordConfirm;

    emit(
      state.copyWith(
        codeVerified: codeV,
        emailError: () => emV ? null : AuthErrors.email,
        codeError: () => codeV ? null : AuthErrors.code,
        passwordError: () => pwV ? null : AuthErrors.password,
        passwordConfirmError: () => pw2V ? null : AuthErrors.passwordConfirm,
        bannerError: () => AuthErrors.banner(email: emV, password: pwV),
        status: FormStatus.initial,
      ),
    );
    if (!emV || !codeV || !pwV || !pw2V) return;

    emit(state.copyWith(status: FormStatus.submitting));
    try {
      await _authRepository.changePassword(
        email: email,
        code: state.code.trim(),
        password: state.password,
      );
      emit(state.copyWith(status: FormStatus.success));
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          bannerError: () => e.message,
        ),
      );
    }
  }

  Future<bool> _verify() => _authRepository.verifyCode(
    email: state.email.trim(),
    code: state.code.trim(),
  );
}
