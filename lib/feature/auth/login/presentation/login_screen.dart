import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/core/widgets/buttons/app_text_button.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_form_layout.dart';
import 'package:rentrella/feature/auth/core/widgets/password_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/custom_check_box_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  bool check = false;

  String? _emErr;
  String? _pwErr;
  String? _bannerErr;

  @override
  void dispose() {
    _emCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  bool _validate() {
    final em = _emCtrl.text.trim();
    final pw = _pwCtrl.text;

    final emV = AuthValidators.email(em);
    final pwV = AuthValidators.password(pw);

    setState(() {
      _emErr = emV ? null : AuthErrors.email;
      _pwErr = pwV ? null : AuthErrors.password;
      _bannerErr = AuthErrors.banner(email: emV, password: pwV);
    });

    return emV && pwV;
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormLayout(
      title: '로그인',
      subtitle: 'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
      bannerError: _bannerErr,
      submitLabel: '로그인 하기',
      onSubmit: () {
        if (_validate()) context.goNamed(AppRoutes.home.name);
      },
      footerText: '계정이 없나요?',
      footerAction: '회원가입',
      onFooterAction: () => context.goNamed(AppRoutes.signup.name),
      fields: [
        AppTextField(
          label: '이메일',
          hint: '이메일을 입력해 주세요.',
          prefixIcon: AppIcon.email,
          controller: _emCtrl,
          error: _emErr,
        ),
        PasswordTextField(
          label: '비밀번호',
          hint: '비밀번호를 입력해 주세요.',
          controller: _pwCtrl,
          error: _pwErr,
        ),
        CustomCheckBoxTile(
          check: check,
          action: (value) => setState(() => check = !check),
          label: '로그인 유지',
          suffix: Expanded(
            child: Align(
              alignment: .centerRight,
              child: AppTextButton(
                label: '비밀번호 찾기',
                onPressed: () => context.goNamed(AppRoutes.passwordChange.name),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
