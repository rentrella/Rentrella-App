import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/mock_auth_repository.dart';
import 'package:rentrella/feature/auth/password_change/bloc/password_change_bloc.dart';

void main() {
  PasswordChangeBloc build() =>
      PasswordChangeBloc(authRepository: MockAuthRepository());

  blocTest<PasswordChangeBloc, PasswordChangeState>(
    '인증코드가 틀리면 코드 에러를 표시한다',
    build: build,
    act: (bloc) => bloc
      ..add(const PasswordChangeCodeChanged('000000'))
      ..add(const PasswordChangeCodeVerified()),
    verify: (bloc) {
      expect(bloc.state.codeVerified, isFalse);
      expect(bloc.state.codeError, AuthErrors.code);
    },
  );

  blocTest<PasswordChangeBloc, PasswordChangeState>(
    '이메일 형식이 틀리면 인증코드를 발송하지 않는다',
    build: build,
    act: (bloc) => bloc.add(const PasswordChangeCodeRequested()),
    verify: (bloc) {
      expect(bloc.state.codeSent, isFalse);
      expect(bloc.state.emailError, AuthErrors.email);
    },
  );

  blocTest<PasswordChangeBloc, PasswordChangeState>(
    '모든 입력이 올바르면 success가 된다',
    build: build,
    act: (bloc) => bloc
      ..add(const PasswordChangeEmailChanged('s12345@gsm.hs.kr'))
      ..add(const PasswordChangeCodeChanged(MockAuthRepository.mockCode))
      ..add(const PasswordChangePasswordChanged('abc123'))
      ..add(const PasswordChangePasswordConfirmChanged('abc123'))
      ..add(const PasswordChangeSubmitted()),
    verify: (bloc) => expect(bloc.state.status, FormStatus.success),
  );
}
