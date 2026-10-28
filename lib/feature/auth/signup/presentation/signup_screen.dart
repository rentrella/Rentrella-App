import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/enum/form_status.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_action_button.dart';
import 'package:rentrella/feature/auth/core/widgets/auth_form_layout.dart';
import 'package:rentrella/feature/auth/core/widgets/password_text_field.dart';
import 'package:rentrella/feature/auth/core/widgets/custom_check_box_tile.dart';
import 'package:rentrella/feature/auth/core/widgets/password_security_card.dart';
import 'package:rentrella/feature/auth/signup/bloc/signup_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(authRepository: context.read()),
      child: const _SignupView(),
    );
  }
}

class _SignupView extends StatelessWidget {
  const _SignupView();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupBloc>();

    return BlocConsumer<SignupBloc, SignupState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == FormStatus.success) {
          context.goNamed(AppRoutes.login.name);
        }
      },
      builder: (context, state) => AuthFormLayout(
        title: '회원가입',
        subtitle: 'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
        bannerError: state.bannerError,
        submitLabel: '회원가입 하기',
        onSubmit: state.status.isSubmitting
            ? null
            : () => bloc.add(const SignupSubmitted()),
        footerText: '이미 계정이 있나요?',
        footerAction: '로그인',
        onFooterAction: () => context.goNamed(AppRoutes.login.name),
        fields: [
          AppTextField(
            label: '이름',
            hint: '이름을 입력해 주세요.',
            prefixIcon: AppIcon.personOutline,
            onChanged: (v) => bloc.add(SignupNameChanged(v)),
            error: state.nameError,
          ),
          AppTextField(
            action: AuthActionButton(
              title: state.codeSent ? '재발송' : '인증코드 발송',
              onPressed: () => bloc.add(const SignupCodeRequested()),
            ),
            label: '이메일',
            hint: '이메일을 입력해 주세요.',
            prefixIcon: AppIcon.email,
            onChanged: (v) => bloc.add(SignupEmailChanged(v)),
            error: state.emailError,
          ),
          AppTextField(
            label: '인증코드',
            hint: '이메일로 받은 인증번호를 입력해주세요.',
            prefixIcon: AppIcon.key,
            onChanged: (v) => bloc.add(SignupCodeChanged(v)),
            error: state.codeError,
          ),
          PasswordTextField(
            label: '비밀번호',
            hint: '비밀번호를 입력해 주세요.',
            onChanged: (v) => bloc.add(SignupPasswordChanged(v)),
            error: state.passwordError,
          ),
          const PasswordSecurityCard(level: .middle),
          PasswordTextField(
            label: '비밀번호 확인',
            hint: '비밀번호를 다시 입력해 주세요.',
            onChanged: (v) => bloc.add(SignupPasswordConfirmChanged(v)),
            error: state.passwordConfirmError,
          ),
          _CheckTermTile(
            check: state.agreed,
            action: (_) => bloc.add(const SignupTermsToggled()),
          ),
        ],
      ),
    );
  }
}

class _CheckTermTile extends StatefulWidget {
  const _CheckTermTile({required this.check, required this.action});

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
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
              padding: EdgeInsets.only(top: AppSpacing.s12),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: const [AppShadow.button],
                  borderRadius: BorderRadius.circular(AppRadius.r8),
                  border: Border.all(color: AppColors.subL_3, width: 1),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.s16,
                  vertical: AppSpacing.s12,
                ),
                child: Column(
                  spacing: AppSpacing.s12,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: AppSpacing.s8,
    children: [
      Text(title, style: AppTextStyle.button1),
      SizedBox(
        width: double.infinity,
        child: Text(content, style: AppTextStyle.content3),
      ),
    ],
  );
}
