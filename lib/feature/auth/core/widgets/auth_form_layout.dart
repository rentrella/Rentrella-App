import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/app_banner.dart';
import 'package:rentrella/core/widgets/app_error_banner.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';
import 'package:rentrella/core/widgets/buttons/app_text_button.dart';
import 'package:rentrella/core/widgets/buttons/submit_button.dart';

/// 인증 화면 공통 레이아웃
///
/// 제목/부제목 + 스크롤 폼 영역, 하단 에러 배너, 제출 버튼과 안내 링크로 구성된다.
class AuthFormLayout extends StatelessWidget {
  const AuthFormLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.submitLabel,
    required this.onSubmit,
    required this.footerText,
    required this.footerAction,
    required this.onFooterAction,
    this.bannerError,
  });

  final String title;
  final String subtitle;

  /// 폼 필드 목록 (간격 28로 배치)
  final List<Widget> fields;

  final String submitLabel;
  final VoidCallback? onSubmit;

  /// 하단 안내 문구와 링크 (예: "계정이 없나요?" / "회원가입")
  final String footerText;
  final String footerAction;
  final VoidCallback onFooterAction;

  /// 하단 에러 배너 메시지. null이면 숨김
  final String? bannerError;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const AppBanner(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: .symmetric(
                vertical: AppSpacing.s24,
                horizontal: AppSpacing.s16,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(title, style: AppTextStyle.title1),
                  Text(
                    subtitle,
                    style: AppTextStyle.body4.copyWith(color: AppColors.subD_4),
                  ),

                  AppSpacing.s24.gapH,

                  Column(spacing: AppSpacing.s28, children: fields),
                ],
              ),
            ),
          ),

          AppErrorBanner(message: bannerError),

          Material(
            color: AppColors.white,
            child: Padding(
              padding: .symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              child: Column(
                spacing: AppSpacing.s12,
                children: [
                  SubmitButton(onPressed: onSubmit, title: submitLabel),
                  Padding(
                    padding: .all(AppSpacing.s4),
                    child: Row(
                      spacing: AppSpacing.s16,
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          footerText,
                          style: AppTextStyle.content2.copyWith(
                            color: AppColors.subL_1,
                          ),
                        ),
                        AppTextButton(
                          label: footerAction,
                          color: AppColors.pD_3,
                          onPressed: onFooterAction,
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
