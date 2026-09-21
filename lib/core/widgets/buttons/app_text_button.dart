import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBaseButton(
      onPressed: onPressed,
      splashColor: AppColors.subL_1,
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s2),
        child: Text(
          label,
          style: AppTextStyle.content1.copyWith(
            color: color ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
