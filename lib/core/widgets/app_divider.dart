import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    required this.pad,
    this.color = AppColors.subL_4,
    this.thickness = 1,
  });

  final EdgeInsets pad;
  final Color color;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pad,
      child: Divider(color: color, height: 1, thickness: thickness),
    );
  }
}
