import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentrella/core/enum/weather_status.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/feature/home/presentation/widgets/banners/cloudy_banner.dart';
import 'package:rentrella/feature/home/presentation/widgets/banners/rainy_banner.dart';
import 'package:rentrella/feature/home/presentation/widgets/banners/snowy_banner.dart';
import 'package:rentrella/feature/home/presentation/widgets/banners/sunny_banner.dart';

typedef TotalPerEnables = ({int total, int enables});

class WeatherBanner extends StatelessWidget {
  const WeatherBanner({
    super.key,
    required this.status,
    required this.available,
    required this.temperature,
    required this.totalPerEnables,
  });

  final bool available;
  final TotalPerEnables totalPerEnables;
  final WeatherStatus status;
  final double temperature;

  AppIcon get _weatherIcon => switch (status) {
    WeatherStatus.rainy => .rain,
    WeatherStatus.cloudy => .cloudy,
    WeatherStatus.sunny => .sunny,
    WeatherStatus.snowy => .snow,
  };

  AppIcon get _temperatureIcon {
    if (temperature > 25) return .temperatureHigh;
    return .temperatureLow;
  }

  @override
  Widget build(BuildContext context) {
    final Widget background = switch (status) {
      WeatherStatus.rainy => const RainyBanner(),
      WeatherStatus.cloudy => const CloudyBanner(),
      WeatherStatus.sunny => const SunnyBanner(),
      WeatherStatus.snowy => const SnowyBanner(),
    };

    return ClipRRect(
      borderRadius: .circular(AppRadius.r12),
      child: SizedBox(
        height: AppSize.s120,
        width: .infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            background,
            Padding(
              padding: .symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s12,
              ),
              child: Column(
                crossAxisAlignment: .start,
                mainAxisAlignment: .center,
                spacing: AppSpacing.s2,
                children: [
                  Text(
                    available ? '현재 대여 가능' : '현재 대여 불가능',
                    style: AppTextStyle.content2.copyWith(
                      color: AppColors.white,
                    ),
                  ),

                  Row(
                    crossAxisAlignment: .end,
                    children: [
                      Text(
                        '${totalPerEnables.total}',
                        style: AppTextStyle.h1.copyWith(color: AppColors.white),
                      ),
                      Opacity(
                        opacity: .6,
                        child: Text(
                          ' / ${totalPerEnables.enables}',
                          style: AppTextStyle.title2.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    spacing: AppSpacing.s16,
                    children: [
                      _weatherIcon.icon(
                        color: AppColors.white,
                        size: AppSize.s16,
                      ),

                      Text(
                        '현재 날씨: ${status.label}',
                        style: AppTextStyle.content3.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      Text(
                        '•',
                        style: AppTextStyle.content3.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      _temperatureIcon.icon(
                        color: AppColors.white,
                        size: AppSize.s16,
                      ),

                      Text(
                        '${NumberFormat('0.0').format(temperature)}°C',
                        style: AppTextStyle.content3.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
