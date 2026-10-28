import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_action_button.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_form_layout.dart';
import 'package:rentrella/feature/auth/core/widgets/password_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/password_security_card.dart';
import 'package:rentrella/feature/auth/password_change/bloc/password_change_bloc.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordChangeBloc(authRepository: context.read()),
      child: const _PasswordChangeView(),
    );
  }
}

class _PasswordChangeView extends StatelessWidget {
  const _PasswordChangeView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PasswordChangeBloc>();

    return BlocConsumer<PasswordChangeBloc, PasswordChangeState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status != FormStatus.success) return;
        // 마이페이지에서 push로 진입한 경우 이전 화면으로 복귀
        if (context.canPop()) {
          context.pop();
        } else {
          context.goNamed(AppRoutes.login.name);
        }
      },
      builder: (context, state) => AuthFormLayout(
        title: '비밀번호 변경하기',
        subtitle: '이메일 인증 이후 비밀번호를 변경할 수 있어요.',
        bannerError: state.bannerError,
        submitLabel: '비밀번호 변경하기',
        onSubmit: state.status.isSubmitting
            ? null
            : () => bloc.add(const PasswordChangeSubmitted()),
        footerText: '비밀번호가 기억나셨나요?',
        footerAction: '로그인으로 돌아가기',
        onFooterAction: () => context.goNamed(AppRoutes.login.name),
        fields: [
          AppTextField(
            action: AuthActionButton(
              title: state.codeSent ? '재발송' : '인증코드 발송',
              onPressed: () => bloc.add(const PasswordChangeCodeRequested()),
            ),
            label: '이메일',
            hint: '이메일을 입력해 주세요.',
            prefixIcon: AppIcon.email,
            onChanged: (v) => bloc.add(PasswordChangeEmailChanged(v)),
            error: state.emailError,
          ),
          AppTextField(
            action: AuthActionButton(
              title: '확인',
              onPressed: state.codeVerified
                  ? null
                  : () => bloc.add(const PasswordChangeCodeVerified()),
            ),
            label: '인증코드',
            hint: '인증번호 6자리를 입력해주세요.',
            prefixIcon: AppIcon.key,
            error: state.codeError,
            onChanged: (v) => bloc.add(PasswordChangeCodeChanged(v)),
          ),
          PasswordTextField(
            label: '비밀번호',
            hint: '비밀번호를 입력해 주세요.',
            onChanged: (v) => bloc.add(PasswordChangePasswordChanged(v)),
            error: state.passwordError,
          ),
          const PasswordSecurityCard(level: .middle),
          PasswordTextField(
            label: '비밀번호 확인',
            hint: '비밀번호를 다시 입력해 주세요.',
            onChanged: (v) => bloc.add(PasswordChangePasswordConfirmChanged(v)),
            error: state.passwordConfirmError,
          ),
        ],
      ),
    );
  }
}
