import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_form_layout.dart';
import 'package:rentrella/feature/auth/core/widgets/password_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/password_security_card.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  final _emCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  bool check = false;

  String? _emErr;
  String? _codeErr;
  String? _pwErr;
  String? _pw2Err;
  String? _bannerErr;

  @override
  void dispose() {
    _emCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  void _validate() {
    final em = _emCtrl.text.trim();
    final code = _codeCtrl.text.trim();
    final pw = _pwCtrl.text;
    final pw2 = _pw2Ctrl.text;

    final emV = AuthValidators.email(em);
    final codeV = code == '123456';
    final pwV = AuthValidators.password(pw);
    final pw2V = pw == pw2;

    setState(() {
      _emErr = emV ? null : AuthErrors.email;
      _codeErr = codeV ? null : AuthErrors.code;
      _pwErr = pwV ? null : AuthErrors.password;
      _pw2Err = pw2V ? null : AuthErrors.passwordConfirm;
      _bannerErr = AuthErrors.banner(email: emV, password: pwV);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      title: '비밀번호 변경하기',
      subtitle: '이메일 인증 이후 비밀번호를 변경할 수 있어요.',
      bannerError: _bannerErr,
      submitLabel: '비밀번호 변경하기',
      onSubmit: _validate,
      footerText: '비밀번호가 기억나셨나요?',
      footerAction: '로그인으로 돌아가기',
      onFooterAction: () => context.goNamed(AppRoutes.login.name),
      fields: [
        AppTextField(
          action: _ActionButton(title: '인증코드 발송', onPressed: () {}),
          label: '이메일',
          hint: '이메일을 입력해 주세요.',
          prefixIcon: AppIcon.email,
          controller: _emCtrl,
          error: _emErr,
        ),
        AppTextField(
          action: _ActionButton(title: '확인', onPressed: () {}),
          label: '인증코드',
          hint: '인증번호 6자리를 입력해주세요.',
          prefixIcon: AppIcon.key,
          error: _codeErr,
          controller: _codeCtrl,
        ),
        PasswordTextField(
          label: '비밀번호',
          hint: '비밀번호를 입력해 주세요.',
          controller: _pwCtrl,
          error: _pwErr,
        ),
        const PasswordSecurityCard(level: .middle),
        PasswordTextField(
          label: '비밀번호 확인',
          hint: '비밀번호를 다시 입력해 주세요.',
          controller: _pw2Ctrl,
          error: _pw2Err,
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enable = onPressed != null;

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      color: enable ? AppColors.primary : AppColors.subL_3,
      boxShadow: enable ? const [AppShadow.button] : null,
    );

    return Container(
      width: AppSize.s88,
      decoration: decoration,
      child: AppBaseButton(
        radius: AppRadius.r8,
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.s8,
            vertical: AppSpacing.s12,
          ),
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.button2.copyWith(
                color: enable ? AppColors.white : AppColors.subL_2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
