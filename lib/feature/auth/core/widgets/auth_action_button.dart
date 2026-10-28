import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

/// 입력 필드 우측 버튼 (인증코드 발송·확인). `onPressed`가 null이면 비활성
class AuthActionButton extends StatelessWidget {
  const AuthActionButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

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
