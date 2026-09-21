import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.background = AppColors.primary,
  });

  final String label;
  final VoidCallback? onPressed;

  final Color? background;

  @override
  Widget build(BuildContext context) {
    final bool enable = onPressed != null;

    final decoration = BoxDecoration(
      color: background,
      borderRadius: .circular(AppRadius.r8),
      boxShadow: const [AppShadow.card],
    );

    return Container(
      decoration: enable
          ? decoration
          : decoration.copyWith(color: AppColors.subL_3, boxShadow: null),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r8,
        child: Padding(
          padding: .symmetric(vertical: AppSpacing.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyle.button2.copyWith(
                  color: enable ? Colors.white : AppColors.subL_2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
