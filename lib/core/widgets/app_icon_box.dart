import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

/// 색 배경 위에 흰 아이콘을 올린 박스 (Figma: umbrella-Icon)
class AppIconBox extends StatelessWidget {
  const AppIconBox({
    super.key,
    required this.icon,
    required this.background,
    this.size,
    this.radius,
    this.pad,
  });

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
