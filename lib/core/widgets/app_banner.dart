import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';

import '../theme/constants/app_spacing.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({super.key, this.suffix, this.emphasis = true});

  final Widget? suffix;
  final bool emphasis;

  static final _decoration = BoxDecoration(
    color: AppColors.white,
    boxShadow: const [AppShadow.card],
    border: Border.all(color: AppColors.subL_3, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: emphasis
          ? _decoration
          : _decoration.copyWith(boxShadow: null, border: null),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.s18,
        vertical: AppSpacing.s8,
      ),
      child: Row(
        children: [
          AppIcon.appLogo.icon(width: AppSize.s160),
          const Spacer(),
          ?suffix,
        ],
      ),
    );
  }
}
