import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

/// 상태 라벨 칩 (Figma: umbrella-label). 우산 상태 · 알림 상태 등에 사용
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    required this.background,
    required this.color,
  });

  final String label;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(AppRadius.r18),
        color: background,
      ),
      padding: .symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
      child: Text(label, style: AppTextStyle.content4.copyWith(color: color)),
    );
  }
}
