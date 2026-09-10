import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/app_base_button.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.title, required this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enable = onPressed != null;

    final decoration = BoxDecoration(
      borderRadius: .circular(AppRadius.r8),
      boxShadow: const [AppShadow.card],
    );

    final style = AppTextStyle.button2;

    return Container(
      decoration: enable
          ? decoration.copyWith(
              gradient: const LinearGradient(
                begin: Alignment(.5, 0),
                end: Alignment(.5, 1),
                colors: [AppColors.pD_4, AppColors.pD_3],
              ),
            )
          : decoration.copyWith(color: AppColors.subL_3),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r8,
        child: Padding(
          padding: const .symmetric(vertical: AppSpacing.s12),
          child: Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                title,
                style: enable
                    ? style.copyWith(color: AppColors.white)
                    : style.copyWith(color: AppColors.subL_2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
