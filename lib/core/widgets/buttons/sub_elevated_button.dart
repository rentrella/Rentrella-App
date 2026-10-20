import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

/// 회색 배경 보조 버튼 (Figma: button-elevated-sub). 다이얼로그 취소·선택지 등에 사용
class SubElevatedButton extends StatelessWidget {
  const SubElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.trailing,
  });

  final String label;
  final VoidCallback? onPressed;

  /// 라벨 오른쪽 위젯 (예: 라디오 표시)
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.subL_4,
        borderRadius: .circular(AppRadius.r8),
        boxShadow: const [AppShadow.soft],
      ),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r8,
        splashColor: AppColors.subL_3,
        child: Padding(
          padding: .symmetric(
            horizontal: AppSpacing.s16,
            vertical: AppSpacing.s12,
          ),
          child: Row(
            mainAxisAlignment: .center,
            spacing: AppSpacing.s8,
            children: [
              Text(
                label,
                style: AppTextStyle.button2.copyWith(color: AppColors.subD_2),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
