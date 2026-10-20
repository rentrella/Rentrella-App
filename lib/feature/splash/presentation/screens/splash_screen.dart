import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();

    // TODO 자동 로그인 도입 시 토큰 확인 후 분기
    Future.delayed(_duration, () {
      if (mounted) context.goNamed(AppRoutes.login.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      backgroundColor: AppColors.white,
      // Figma 기준 로고 중심이 화면 중앙보다 약간 위에 위치
      body: Align(alignment: Alignment(0, -0.08), child: _SplashLogo()),
    );
  }
}

class _SplashLogo extends StatelessWidget {
  const _SplashLogo();

  /// 워드마크 원본 크기 188 × 44.24 (상단 우산 장식이 위로 2.24 넘침)
  static double get _wordmarkWidth => 188.r;
  static double get _wordmarkHeight => 42.r;
  static double get _wordmarkOverflow => 44.2379.r;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      crossAxisAlignment: .end,
      spacing: AppSpacing.s12,
      children: [
        AppIcon.logoIcon.icon(size: AppSize.s64),
        SizedBox(
          width: _wordmarkWidth,
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .end,
            spacing: AppSpacing.s4,
            children: [
              SizedBox(
                height: _wordmarkHeight,
                child: OverflowBox(
                  alignment: .bottomCenter,
                  maxHeight: _wordmarkOverflow,
                  child: AppIcon.logoWordmark.icon(
                    width: _wordmarkWidth,
                    height: _wordmarkOverflow,
                  ),
                ),
              ),
              Text(
                '우산 대여 서비스',
                style: AppTextStyle.button1.copyWith(
                  color: AppColors.subD_4,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
