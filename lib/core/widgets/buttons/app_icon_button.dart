import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onPressed, required this.icon});

  final VoidCallback onPressed;
  final AppIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s36,
      width: AppSize.s36,
      decoration: BoxDecoration(
        shape: .circle,
        color: AppColors.white,
        border: .all(color: AppColors.subL_3, width: 1),
        boxShadow: const [AppShadow.card],
      ),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: 99,
        child: Padding(
          padding: .all(AppSpacing.s8),
          child: icon.icon(size: AppSize.s16, color: AppColors.black),
        ),
      ),
    );
  }
}
