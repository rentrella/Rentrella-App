import 'package:flutter/material.dart';
import 'package:rentrella/core/widgets/base_scaffold.dart';

import '../../../../core/theme/color/app_colors.dart';
import '../../../../core/theme/constants/app_size.dart';
import '../../../../core/theme/constants/app_spacing.dart';
import '../../../../core/theme/font/app_text_style.dart';
import '../../../../core/theme/icon/app_icon.dart';
import '../../../../core/widgets/app_banner.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../widgets/custom_check_box_tile.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool hide = true;
  bool check = false;

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validate() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final emailValid = RegExp(r'^s\d{5}@gsm\.hs\.kr$').hasMatch(email);
    final passwordValid = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+\-=]{6,20}$',
    ).hasMatch(password);

    setState(() {
      _emailError = emailValid ? null : _Errors.email;
      _passwordError = passwordValid ? null : _Errors.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const AppBanner(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.s24,
                  horizontal: AppSpacing.s16,
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text('회원가입', style: AppTextStyle.title1),
                        Text(
                          'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
                          style: AppTextStyle.body4.copyWith(
                            color: AppColors.subD_4,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.s24),

                    Column(
                      spacing: AppSpacing.s28,
                      children: [
                        AppTextField(
                          label: '이메일',
                          hint: '이메일을 입력해 주세요.',
                          prefixIcon: .email,
                          controller: _emailController,
                          error: _emailError,
                        ),
                        AppTextField(
                          label: '비밀번호',
                          hint: '비밀번호를 입력해 주세요.',
                          prefixIcon: .lock,
                          controller: _passwordController,
                          error: _passwordError,
                          hide: hide,
                          suffix: IconButton(
                            style: IconButton.styleFrom(),
                            onPressed: () {
                              setState(() {
                                hide = !hide;
                              });
                            },
                            icon:
                                (hide
                                        ? AppIcon.visibilityOff
                                        : AppIcon.visibility)
                                    .icon(size: AppSize.s12),
                          ),
                        ),

                        CustomCheckBoxTile(
                          check: check,
                          action: (value) {
                            setState(() {
                              check = !check;
                            });
                          },
                          label: '로그인 유지',
                          suffix: Expanded(
                            child: Align(
                              alignment: .centerRight,
                              child: AppTextButton(
                                label: '비밀번호 찾기',
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Material(
            color: AppColors.white,
            child: Padding(
              padding: const .symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              child: Column(
                spacing: AppSpacing.s12,
                children: [
                  PrimaryButton(onPressed: _validate, title: '로그인 하기'),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s4),
                    child: Row(
                      spacing: AppSpacing.s16,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          '계정이 없나요?',
                          style: AppTextStyle.content2.copyWith(
                            color: AppColors.subL_1,
                          ),
                        ),
                        AppTextButton(label: '비밀번호 찾기', onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Errors {
  static const String email = '이메일은 "sXXXX@gsm.hs.kr" 형식을 따라야 합니다.';
  static const String password = '비밀번호는 6-20자 내의 영문+숫자-특수문자 형식을 따라야 합니다.';
}
