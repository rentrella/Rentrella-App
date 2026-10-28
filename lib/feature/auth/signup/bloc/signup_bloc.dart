import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/core/network/api_exception.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this._authRepository}) : super(const SignupState()) {
    on<SignupNameChanged>((e, emit) => emit(state.copyWith(name: e.name)));
    on<SignupEmailChanged>((e, emit) => emit(state.copyWith(email: e.email)));
    on<SignupCodeChanged>((e, emit) => emit(state.copyWith(code: e.code)));
    on<SignupPasswordChanged>(
      (e, emit) => emit(state.copyWith(password: e.password)),
    );
    on<SignupPasswordConfirmChanged>(
      (e, emit) => emit(state.copyWith(passwordConfirm: e.passwordConfirm)),
    );
    on<SignupTermsToggled>(
      (e, emit) => emit(state.copyWith(agreed: !state.agreed)),
    );
    on<SignupCodeRequested>(_onCodeRequested);
    on<SignupSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onCodeRequested(
    SignupCodeRequested event,
    Emitter<SignupState> emit,
  ) async {
    final email = state.email.trim();
    if (!AuthValidators.email(email)) {
      emit(state.copyWith(emailError: () => AuthErrors.email));
      return;
    }

    emit(state.copyWith(emailError: () => null, bannerError: () => null));
    try {
      await _authRepository.sendSignupCode(email: email);
      emit(state.copyWith(codeSent: true));
    } on ApiException catch (e) {
      emit(state.copyWith(bannerError: () => e.message));
    }
  }

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status.isSubmitting) return;

    final name = state.name.trim();
    final email = state.email.trim();
    final code = state.code.trim();
    final nameV = AuthValidators.name(name);
    final emV = AuthValidators.email(email);
    final codeV = code.isNotEmpty;
    final pwV = AuthValidators.password(state.password);
    final pw2V = state.password == state.passwordConfirm;

    emit(
      state.copyWith(
        nameError: () => nameV ? null : AuthErrors.name,
        emailError: () => emV ? null : AuthErrors.email,
        codeError: () => codeV ? null : AuthErrors.codeRequired,
        passwordError: () => pwV ? null : AuthErrors.password,
        passwordConfirmError: () => pw2V ? null : AuthErrors.passwordConfirm,
        bannerError: () => null,
        status: FormStatus.initial,
      ),
    );
    if (!nameV || !emV || !codeV || !pwV || !pw2V) return;

    emit(state.copyWith(status: FormStatus.submitting));
    try {
      await _authRepository.signup(
        email: email,
        password: state.password,
        name: name,
        verificationCode: code,
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
}
