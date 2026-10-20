import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

class MyPageButtonTile extends StatelessWidget {
  const MyPageButtonTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final AppIcon icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.subL_5,
        borderRadius: .circular(AppRadius.r8),
        border: const Border(
          bottom: BorderSide(color: AppColors.subL_2, width: 0.5),
        ),
      ),
      clipBehavior: .antiAlias,
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r8,
        child: Padding(
          padding: .symmetric(
            vertical: AppSpacing.s12,
            horizontal: AppSpacing.s16,
          ),
          child: Row(
            children: [
              icon.icon(color: AppColors.black, size: AppSize.s18),
              AppSpacing.s16.gapW,
              Text(
                label,
                style: AppTextStyle.button2.copyWith(color: AppColors.subD_2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
