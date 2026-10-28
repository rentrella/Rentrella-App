import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/data/repositories/mock_auth_repository.dart';
import 'package:rentrella/feature/auth/signup/bloc/signup_bloc.dart';

void main() {
  SignupBloc build() => SignupBloc(authRepository: MockAuthRepository());

  SignupBloc fill(SignupBloc bloc, {required String code}) => bloc
    ..add(const SignupNameChanged('홍길동'))
    ..add(const SignupEmailChanged('s12345@gsm.hs.kr'))
    ..add(SignupCodeChanged(code))
    ..add(const SignupPasswordChanged('abc12345'))
    ..add(const SignupPasswordConfirmChanged('abc12345'));

  blocTest<SignupBloc, SignupState>(
    '이름·인증코드가 비어 있으면 필드 에러를 표시하고 제출하지 않는다',
    build: build,
    act: (bloc) => bloc
      ..add(const SignupEmailChanged('s12345@gsm.hs.kr'))
      ..add(const SignupPasswordChanged('abc12345'))
      ..add(const SignupPasswordConfirmChanged('abc12345'))
      ..add(const SignupSubmitted()),
    verify: (bloc) {
      expect(bloc.state.nameError, AuthErrors.name);
      expect(bloc.state.codeError, AuthErrors.codeRequired);
      expect(bloc.state.status, FormStatus.initial);
    },
  );

  blocTest<SignupBloc, SignupState>(
    '비밀번호가 8자 미만이면 에러',
    build: build,
    act: (bloc) => bloc
      ..add(const SignupPasswordChanged('abc1234'))
      ..add(const SignupSubmitted()),
    verify: (bloc) => expect(bloc.state.passwordError, AuthErrors.password),
  );

  blocTest<SignupBloc, SignupState>(
    '인증코드 발송 후 올바른 입력이면 success',
    build: build,
    act: (bloc) async {
      bloc
        ..add(const SignupEmailChanged('s12345@gsm.hs.kr'))
        ..add(const SignupCodeRequested());
      await Future<void>.delayed(Duration.zero);
      fill(
        bloc,
        code: MockAuthRepository.mockCode,
      ).add(const SignupSubmitted());
    },
    verify: (bloc) {
      expect(bloc.state.codeSent, isTrue);
      expect(bloc.state.status, FormStatus.success);
    },
  );

  blocTest<SignupBloc, SignupState>(
    '서버 에러 메시지를 배너로 표시한다',
    build: build,
    act: (bloc) => fill(bloc, code: '000000').add(const SignupSubmitted()),
    verify: (bloc) {
      expect(bloc.state.status, FormStatus.failure);
      expect(bloc.state.bannerError, '인증코드 불일치');
    },
  );
}
