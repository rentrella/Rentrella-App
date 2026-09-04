import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

class CustomCheckBoxTile extends StatelessWidget {
  const CustomCheckBoxTile({
    super.key,
    required this.check,
    required this.label,
    required this.action,
    this.suffix,
  });

  final bool check;
  final ValueChanged<bool?> action;
  final Widget? suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s12,
      children: [
        SizedBox.square(
          dimension: AppSize.s16,
          child: Checkbox(
            overlayColor: .all(AppColors.subL_1.withAlpha(32)),
            materialTapTargetSize: .shrinkWrap,
            activeColor: AppColors.primary,
            value: check,
            shape: RoundedRectangleBorder(
              borderRadius: .circular(AppRadius.r4),
            ),
            side: const BorderSide(color: AppColors.primary, width: 2),
            onChanged: action,
          ),
        ),

        Text(
          label,
          style: AppTextStyle.body4.copyWith(color: AppColors.subD_3),
        ),

        ?suffix,
      ],
    );
  }
}
