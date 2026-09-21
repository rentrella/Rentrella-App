import 'package:flutter/material.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

class UmbrellaStatusIcon extends StatelessWidget {
  const UmbrellaStatusIcon._({
    required this.icon,
    required this.background,
    this.size,
    this.radius,
    this.pad,
  });

  factory UmbrellaStatusIcon.fromStatus(
    UmbrellaStatus status, {
    double? size,
    double? radius,
    double? pad,
  }) {
    return switch (status) {
      UmbrellaStatus.ready => UmbrellaStatusIcon._(
        icon: .umbrellaFold,
        background: AppColors.primary,
        size: size,
        radius: radius,
        pad: pad,
      ),
      UmbrellaStatus.rentingByMe ||
      UmbrellaStatus.rented => UmbrellaStatusIcon._(
        icon: .umbrellaOpen,
        background: AppColors.g_2,
        size: size,
        radius: radius,
        pad: pad,
      ),
      UmbrellaStatus.overdue ||
      UmbrellaStatus.overdueByMe => UmbrellaStatusIcon._(
        icon: .umbrellaFlipped,
        background: AppColors.r_2,
        size: size,
        radius: radius,
        pad: pad,
      ),
      UmbrellaStatus.broken ||
      UmbrellaStatus.unavailable => UmbrellaStatusIcon._(
        icon: .umbrellaRolled,
        background: AppColors.subL_1,
        size: size,
        radius: radius,
        pad: pad,
      ),
    };
  }

  final AppIcon icon;
  final Color background;
  final double? size;
  final double? radius;
  final double? pad;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: .circular(radius ?? AppRadius.r8),
      ),
      padding: .all(pad ?? AppSpacing.s8),
      child: icon.icon(color: AppColors.white, size: size),
    );
  }
}
