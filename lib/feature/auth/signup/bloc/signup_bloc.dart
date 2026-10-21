import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this._authRepository}) : super(const SignupState()) {
    on<SignupEmailChanged>((e, emit) => emit(state.copyWith(email: e.email)));
    on<SignupPasswordChanged>(
      (e, emit) => emit(state.copyWith(password: e.password)),
    );
    on<SignupPasswordConfirmChanged>(
      (e, emit) => emit(state.copyWith(passwordConfirm: e.passwordConfirm)),
    );
    on<SignupTermsToggled>(
      (e, emit) => emit(state.copyWith(agreed: !state.agreed)),
    );
    on<SignupSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status.isSubmitting) return;

    final email = state.email.trim();
    final emV = AuthValidators.email(email);
    final pwV = AuthValidators.password(state.password);
    final pw2V = state.password == state.passwordConfirm;

    emit(
      state.copyWith(
        emailError: () => emV ? null : AuthErrors.email,
        passwordError: () => pwV ? null : AuthErrors.password,
        passwordConfirmError: () => pw2V ? null : AuthErrors.passwordConfirm,
        bannerError: () => null,
        status: FormStatus.initial,
      ),
    );
    if (!emV || !pwV || !pw2V) return;

    emit(state.copyWith(status: FormStatus.submitting));
    try {
      await _authRepository.signup(email: email, password: state.password);
      emit(state.copyWith(status: FormStatus.success));
    } on AuthException catch (e) {
      emit(
        state.copyWith(
          status: FormStatus.failure,
          bannerError: () => e.message,
        ),
      );
    }
  }
}
