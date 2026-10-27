import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this._authRepository}) : super(const LoginState()) {
    on<LoginEmailChanged>((e, emit) => emit(state.copyWith(email: e.email)));
    on<LoginPasswordChanged>(
      (e, emit) => emit(state.copyWith(password: e.password)),
    );
    on<LoginKeepToggled>(
      (e, emit) => emit(state.copyWith(keepLoggedIn: !state.keepLoggedIn)),
    );
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _authRepository;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isSubmitting) return;

    final email = state.email.trim();
    final emV = AuthValidators.email(email);
    final pwV = AuthValidators.password(state.password);

    emit(
      state.copyWith(
        emailError: () => emV ? null : AuthErrors.email,
        passwordError: () => pwV ? null : AuthErrors.password,
        bannerError: () => AuthErrors.banner(email: emV, password: pwV),
        status: FormStatus.initial,
      ),
    );
    if (!emV || !pwV) return;

    emit(state.copyWith(status: FormStatus.submitting));
    try {
      await _authRepository.login(
        email: email,
        password: state.password,
        keepLoggedIn: state.keepLoggedIn,
      );
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
