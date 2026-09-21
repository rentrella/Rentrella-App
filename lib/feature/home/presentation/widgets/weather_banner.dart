import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/feature/home/presentation/home_screen.dart';

class WeatherBanner extends StatefulWidget {
  const WeatherBanner({super.key});

  @override
  State<WeatherBanner> createState() => _WeatherBannerState();
}

class _WeatherBannerState extends State<WeatherBanner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s120,
      width: .infinity,
      decoration: BoxDecoration(
        borderRadius: .circular(AppRadius.r12),
        color: AppColors.subL_4,
      ),
      padding: .symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s12),
      child: const Column(children: []),
    );
  }
}
