import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/mock_auth_repository.dart';
import 'package:rentrella/feature/auth/login/bloc/login_bloc.dart';

void main() {
  LoginBloc build() => LoginBloc(authRepository: MockAuthRepository());

  blocTest<LoginBloc, LoginState>(
    '형식이 틀리면 필드·배너 에러를 표시하고 제출하지 않는다',
    build: build,
    act: (bloc) => bloc
      ..add(const LoginEmailChanged('wrong'))
      ..add(const LoginSubmitted()),
    skip: 1,
    expect: () => [
      const LoginState(
        email: 'wrong',
        emailError: AuthErrors.email,
        passwordError: AuthErrors.password,
        bannerError: AuthErrors.emailBanner,
      ),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    '올바른 입력이면 제출 후 success가 된다',
    build: build,
    act: (bloc) => bloc
      ..add(const LoginEmailChanged('s12345@gsm.hs.kr'))
      ..add(const LoginPasswordChanged('abc123'))
      ..add(const LoginSubmitted()),
    verify: (bloc) {
      expect(bloc.state.status, FormStatus.success);
      expect(bloc.state.bannerError, isNull);
    },
  );

  blocTest<LoginBloc, LoginState>(
    '로그인 유지 토글',
    build: build,
    act: (bloc) => bloc.add(const LoginKeepToggled()),
    expect: () => [const LoginState(keepLoggedIn: true)],
  );
}
