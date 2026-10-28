import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/core/widgets/buttons/app_text_button.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_form_layout.dart';
import 'package:rentrella/feature/auth/core/widgets/password_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/custom_check_box_tile.dart';
import 'package:rentrella/feature/auth/login/bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authRepository: context.read()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          context.goNamed(AppRoutes.home.name);
        }
      },
      builder: (context, state) => AuthFormLayout(
        title: '로그인',
        subtitle: 'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
        bannerError: state.bannerError,
        submitLabel: '로그인 하기',
        onSubmit: state.status.isSubmitting
            ? null
            : () => bloc.add(const LoginSubmitted()),
        footerText: '계정이 없나요?',
        footerAction: '회원가입',
        onFooterAction: () => context.goNamed(AppRoutes.signup.name),
        fields: [
          AppTextField(
            label: '이메일',
            hint: '이메일을 입력해 주세요.',
            prefixIcon: AppIcon.email,
            onChanged: (v) => bloc.add(LoginEmailChanged(v)),
            textInputAction: TextInputAction.next,
            error: state.emailError,
          ),
          PasswordTextField(
            label: '비밀번호',
            hint: '비밀번호를 입력해 주세요.',
            onChanged: (v) => bloc.add(LoginPasswordChanged(v)),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => bloc.add(const LoginSubmitted()),
            error: state.passwordError,
          ),
          CustomCheckBoxTile(
            check: state.keepLoggedIn,
            action: (_) => bloc.add(const LoginKeepToggled()),
            label: '로그인 유지',
            suffix: Expanded(
              child: Align(
                alignment: .centerRight,
                child: AppTextButton(
                  label: '비밀번호 찾기',
                  onPressed: () =>
                      context.goNamed(AppRoutes.passwordChange.name),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
