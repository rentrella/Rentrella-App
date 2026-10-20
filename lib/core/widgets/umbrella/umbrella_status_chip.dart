import 'package:flutter/material.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/widgets/app_chip.dart';

import '../../theme/color/app_colors.dart';

class UmbrellaStatusChip extends StatelessWidget {
  const UmbrellaStatusChip.fromStatus(this.status, {super.key});

  final UmbrellaStatus status;

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      UmbrellaStatus.ready => const AppChip(
        label: '준비됨',
        background: AppColors.pL_4,
        color: AppColors.pD_3,
      ),
      UmbrellaStatus.rentingByMe => const AppChip(
        label: '대여중 ',
        background: AppColors.g_3,
        color: AppColors.g_2,
      ),
      UmbrellaStatus.overdueByMe => const AppChip(
        label: '연체됨',
        background: AppColors.r_3,
        color: AppColors.r_2,
      ),
      UmbrellaStatus.overdue ||
      UmbrellaStatus.rented ||
      UmbrellaStatus.unavailable ||
      UmbrellaStatus.broken => const AppChip(
        label: '대여불가',
        background: AppColors.subL_3,
        color: AppColors.subD_4,
      ),
    };
  }
}
