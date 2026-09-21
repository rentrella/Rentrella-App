import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_state_chip.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_state_icon.dart';

class UmbrellaCard extends StatelessWidget {
  const UmbrellaCard({super.key, required this.enable});

  final bool enable;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: .all(color: AppColors.subL_4, width: 1),
        borderRadius: .circular(AppRadius.r12),
      ),
      child: Column(
        children: [
          Row(children: [UmbrellaStateIcon.ready(), UmbrellaStateChip.ready()]),
        ],
      ),
    );
  }
}
