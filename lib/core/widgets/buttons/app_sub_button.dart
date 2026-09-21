import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

class AppSubButton extends StatelessWidget {
  const AppSubButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });

  final String title;
  final AppIcon? icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.subL_3, width: 1),
        borderRadius: BorderRadius.circular(AppRadius.r12),
      ),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r12,
        child: Padding(
          padding: .symmetric(
            horizontal: AppSpacing.s8,
            vertical: AppSpacing.s4,
          ),
          child: Row(
            spacing: AppSpacing.s8,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) icon!.icon(),
              Text(
                title,
                style: AppTextStyle.content5.copyWith(color: AppColors.subD_2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
