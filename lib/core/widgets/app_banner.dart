import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

import '../theme/constants/app_spacing.dart';

class AppBanner extends StatelessWidget implements PreferredSizeWidget {
  const AppBanner({super.key});

  @override
  Size get preferredSize => .fromHeight(AppSize.s68);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: AppSize.s68,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s18),
        child: AppIcon.appLogo.icon(),
      ),
      leadingWidth: 160 + AppSpacing.s18 * 2,
      shape: Border.all(color: AppColors.subL_3, width: 1),
      shadowColor: AppColors.subL_3,
      elevation: 4,
    );
  }
}
