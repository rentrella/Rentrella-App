import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

class AppBanner extends StatelessWidget implements PreferredSizeWidget {
  const AppBanner({super.key});

  @override
  Size get preferredSize => .fromHeight(68);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      leading: AppIcon.appLogo.icon(),
      leadingWidth: 180,
      shape: Border.all(color: AppColors.subL_3, width: 1),
      shadowColor: AppColors.subL_3,
      elevation: 4,
    );
  }
}
