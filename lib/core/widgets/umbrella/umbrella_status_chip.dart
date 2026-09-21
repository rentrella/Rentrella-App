import 'package:flutter/material.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

import '../../theme/color/app_colors.dart';

class UmbrellaStatusChip extends StatelessWidget {
  const UmbrellaStatusChip._({
    required this.title,
    required this.background,
    required this.color,
  });

  factory UmbrellaStatusChip.fromStatus(UmbrellaStatus status) {
    return switch (status) {
      UmbrellaStatus.ready => const UmbrellaStatusChip._(
        title: '준비됨',
        background: AppColors.pL_4,
        color: AppColors.pD_3,
      ),
      UmbrellaStatus.rentingByMe => const UmbrellaStatusChip._(
        title: '대여중 ',
        background: AppColors.g_3,
        color: AppColors.g_2,
      ),
      UmbrellaStatus.overdueByMe => const UmbrellaStatusChip._(
        title: '연체됨',
        background: AppColors.subL_3,
        color: AppColors.subD_4,
      ),
      UmbrellaStatus.overdue ||
      UmbrellaStatus.rented ||
      UmbrellaStatus.unavailable ||
      UmbrellaStatus.broken => const UmbrellaStatusChip._(
        title: '대여불가',
        background: AppColors.subL_3,
        color: AppColors.subD_4,
      ),
    };
  }

  final String title;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(AppRadius.r18),
        color: background,
      ),
      child: Padding(
        padding: .symmetric(horizontal: AppSpacing.s8, vertical: AppSpacing.s4),
        child: Text(title, style: AppTextStyle.content4.copyWith(color: color)),
      ),
    );
  }
}
