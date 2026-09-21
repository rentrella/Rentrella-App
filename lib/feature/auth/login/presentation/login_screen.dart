import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/app_banner.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';
import 'package:rentrella/core/widgets/buttons/app_text_button.dart';
import 'package:rentrella/core/widgets/buttons/submit_button.dart';
import 'package:rentrella/feature/auth/core/auth_validators.dart';
import 'package:rentrella/feature/auth/core/widgets/custom_check_box_tile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  bool hide = true;
  bool check = false;

  String? _emErr;
  String? _pwErr;

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
    });

    return emV && pwV;
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
                padding: EdgeInsets.symmetric(
                  vertical: AppSpacing.s24,
                  horizontal: AppSpacing.s16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('로그인', style: AppTextStyle.title1),
                        Text(
                          'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
                          style: AppTextStyle.body4.copyWith(
                            color: AppColors.subD_4,
                          ),
                        ),
                      ],
                    ),

                    AppSpacing.s24.gapH,

                    Column(
                      spacing: AppSpacing.s28,
                      children: [
                        AppTextField(
                          label: '이메일',
                          hint: '이메일을 입력해 주세요.',
                          prefixIcon: AppIcon.email,
                          controller: _emCtrl,
                          error: _emErr,
                        ),
                        AppTextField(
                          label: '비밀번호',
                          hint: '비밀번호를 입력해 주세요.',
                          prefixIcon: AppIcon.lock,
                          controller: _pwCtrl,
                          error: _pwErr,
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
                              alignment: Alignment.centerRight,
                              child: AppTextButton(
                                label: '비밀번호 찾기',
                                onPressed: () {
                                  context.goNamed(
                                    AppRoutes.passwordChange.name,
                                  );
                                },
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
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              child: Column(
                spacing: AppSpacing.s12,
                children: [
                  SubmitButton(
                    onPressed: () {
                      if (_validate()) {
                        context.goNamed(AppRoutes.main.name);
                      }
                    },
                    title: '로그인 하기',
                  ),
                  Padding(
                    padding: EdgeInsets.all(AppSpacing.s4),
                    child: Row(
                      spacing: AppSpacing.s16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '계정이 없나요?',
                          style: AppTextStyle.content2.copyWith(
                            color: AppColors.subL_1,
                          ),
                        ),
                        AppTextButton(
                          label: '회원가입',
                          color: AppColors.pD_3,
                          onPressed: () {
                            context.goNamed(AppRoutes.signup.name);
                          },
                        ),
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
