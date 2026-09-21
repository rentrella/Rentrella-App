import 'package:flutter/material.dart';

import '../../theme/color/app_colors.dart';

class AppBaseButton extends StatelessWidget {
  const AppBaseButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.radius,
    this.splashColor = AppColors.subL_5,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final double? radius;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: .transparency,
      child: InkWell(
        borderRadius: .circular(radius ?? 0),
        splashColor: splashColor.withAlpha(180),
        onTap: onPressed,
        child: child,
      ),
    );
  }
}
