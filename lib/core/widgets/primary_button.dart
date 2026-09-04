import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.enable = true,
  });

  final String title;
  final VoidCallback onPressed;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.r8)),
        padding: const .symmetric(vertical: AppSpacing.s12),
      ),
      onPressed: enable ? onPressed : null,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: AppTextStyle.button1.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
