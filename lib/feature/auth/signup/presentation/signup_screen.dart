import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base_scaffold.dart';
import 'package:rentrella/feature/auth/core/widgets/custom_check_box_tile.dart';
import 'package:rentrella/feature/auth/core/widgets/password_security_card.dart';

import '../../../../core/theme/color/app_colors.dart';
import '../../../../core/theme/constants/app_size.dart';
import '../../../../core/theme/constants/app_spacing.dart';
import '../../../../core/theme/font/app_text_style.dart';
import '../../../../core/theme/icon/app_icon.dart';
import '../../../../core/widgets/app_banner.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  bool hide = true;
  bool hide2 = true;
  bool check = false;

  String? _emErr;
  String? _pwErr;
  String? _pw2Err;

  @override
  void dispose() {
    _emCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  void _validate() {
    final em = _emCtrl.text.trim();
    final pw = _pwCtrl.text;
    final pw2 = _pw2Ctrl.text;

    final emV = RegExp(r'^s\d{5}@gsm\.hs\.kr$').hasMatch(em);
    final pwV = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+\-=]{6,20}$',
    ).hasMatch(pw);

    final pw2V = pw == pw2;

    setState(() {
      _emErr = emV ? null : _Errors.email;
      _pwErr = pwV ? null : _Errors.password;
      _pw2Err = pw2V ? null : _Errors.passwordConfirm;
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
                          controller: _emCtrl,
                          error: _emErr,
                        ),

                        AppTextField(
                          label: '비밀번호',
                          hint: '비밀번호를 입력해 주세요.',
                          prefixIcon: .lock,
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

                        const PasswordSecurityCard(level: .middle),

                        AppTextField(
                          label: '비밀번호 확인',
                          hint: '비밀번호를 다시 입력해 주세요.',
                          prefixIcon: .lock,
                          controller: _pw2Ctrl,
                          error: _pw2Err,
                          hide: hide2,
                          suffix: IconButton(
                            style: IconButton.styleFrom(),
                            onPressed: () {
                              setState(() {
                                hide2 = !hide2;
                              });
                            },
                            icon:
                                (hide2
                                        ? AppIcon.visibilityOff
                                        : AppIcon.visibility)
                                    .icon(size: AppSize.s12),
                          ),
                        ),

                        _CheckTermTile(
                          check: check,
                          action: (value) {
                            setState(() {
                              check = !check;
                            });
                          },
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
                  PrimaryButton(onPressed: _validate, title: '회원가입 하기'),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.s4),
                    child: Row(
                      spacing: AppSpacing.s16,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          '이미 계정이 있나요?',
                          style: AppTextStyle.content2.copyWith(
                            color: AppColors.subL_1,
                          ),
                        ),
                        AppTextButton(
                          label: '로그인',
                          onPressed: () {
                            context.goNamed(AppRoutes.login.name);
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

class _CheckTermTile extends StatefulWidget {
  const _CheckTermTile({super.key, required this.check, required this.action});

  final bool check;
  final ValueChanged<bool?> action;

  @override
  State<_CheckTermTile> createState() => _CheckTermTileState();
}

class _CheckTermTileState extends State<_CheckTermTile> {
  bool hide = true;

  final List<(String, String)> terms = [
    (
      '1. 수집하는 개인정보 항목',
      'Rentrella는 회원가입 및 우산 대여 서비스 제공을 위해 학교 이메일, 비밀번호, 서비스 이용 기록, 우산 대여 및 반납 기록을 수집합니다.',
    ),

    (
      '2. 개인정보 수집 목적',
      '수집된 정보는 회원 식별, 학교 구성원 확인, 우산 대여 가능 여부 확인, 반납 관리, 연체 상태 안내, 문의 응대 목적으로만 사용됩니다.',
    ),
    (
      '3. 보관 및 이용 기간',
      '회원 정보는 서비스 이용 기간 동안 보관되며, 회원 탈퇴 또는 서비스 이용 종료 요청 시 지체 없이 삭제됩니다. 단, 대여 및 반납 기록은 분쟁 방지와 운영 기록 확인을 위해 필요한 기간 동안 보관될 수 있습니다.',
    ),
    (
      '4. 동의 거부 권리',
      '사용자는 개인정보 수집 및 이용에 동의하지 않을 수 있습니다. 다만, 필수 정보 수집에 동의하지 않을 경우 Rentrella 회원가입 및 우산 대여 서비스를 이용할 수 없습니다.',
    ),
    (
      '5. 개인정보 보호',
      'Rentrella는 수집된 개인정보가 외부에 임의로 공개되지 않도록 관리하며, 서비스 운영 목적 외의 용도로 사용하지 않습니다. 개인정보 접근은 서비스 운영에 필요한 범위로 제한됩니다.',
    ),
    (
      '6. 문의',
      '개인정보 처리와 관련된 문의는 서비스 내 문의하기 기능을 통해 접수할 수 있습니다.\n접수된 문의는 확인 후 필요한 안내를 제공합니다.',
    ),
    (
      '7. 우산 분실·훼손 및 이용 제한',
      '우산 분실 또는 파손 시 플랫폼이 정한 가액이나 수리비를 배상해야 합니다.\n무단 연체하거나 배상을 완료하지 않으면 플랫폼 이용(계정)이 즉시 정지되며 배상 또는 반납이 완전히 완료될 때까지 유지됩니다.\n본 우산은 학교 기품(공공 재산)이므로 고의 파손이나 미반납 반복 시 학교 당국에 통보되어 추가 불이익을 받을 수 있습니다.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    return Column(
      children: [
        CustomCheckBoxTile(
          check: widget.check,
          action: widget.action,
          label: '개인정보 수집 및 이용에 동의',
          suffix: IconButton(
            style: IconButton.styleFrom(
              minimumSize: .zero,
              tapTargetSize: .shrinkWrap,
            ),
            onPressed: () {
              setState(() {
                hide = !hide;
              });
            },
            icon: AnimatedRotation(
              duration: duration,
              turns: hide ? 0 : -.5,
              child: AppIcon.dropArrowDown.icon(color: AppColors.primary),
            ),
          ),
        ),

        ClipRect(
          child: AnimatedAlign(
            duration: duration,
            curve: Curves.easeInOut,
            heightFactor: hide ? 0.0 : 1.0,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.s12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: const [AppShadow.card],
                  borderRadius: .circular(AppRadius.r8),
                  border: .all(color: AppColors.subL_3, width: 1),
                ),
                padding: const .symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
                child: Column(
                  spacing: AppSpacing.s12,
                  crossAxisAlignment: .start,
                  children: terms
                      .map((e) => _section(title: e.$1, content: e.$2))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _section({required String title, required String content}) => Column(
    crossAxisAlignment: .start,
    spacing: AppSpacing.s8,
    children: [
      Text(title, style: AppTextStyle.button1),
      SizedBox(
        width: .infinity,
        child: Text(content, style: AppTextStyle.content3),
      ),
    ],
  );
}

class _Errors {
  static const String email = '이메일은 "sXXXX@gsm.hs.kr" 형식을 따라야 합니다.';
  static const String password = '비밀번호는 6-20자 내의 영문+숫자-특수문자 형식을 따라야 합니다.';
  static const String passwordConfirm = '비밀번호가 일치하지 않습니다.';
}
