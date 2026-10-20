import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

/// 로고 + 제목 + 닫기 버튼 헤더를 가진 공통 다이얼로그 틀
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    required this.children,
    this.padding,
    this.spacing,
  });

  /// 제목 위젯 (다이얼로그마다 크기가 달라 Text를 그대로 받음)
  final Widget title;
  final List<Widget> children;
  final EdgeInsets? padding;
  final double? spacing;

  static double get _width => 360.r;
  static double get _logoWidth => 72.r;

  /// Figma 기준 배경 딤(pMulk_1, 40%)으로 다이얼로그 표시
  static Future<T?> show<T>(BuildContext context, Widget dialog) =>
      showDialog<T>(
        context: context,
        barrierColor: AppColors.pMulk_1.withValues(alpha: 0.4),
        builder: (_) => dialog,
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: .symmetric(horizontal: AppSpacing.s20),
      child: Container(
        width: _width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: .circular(AppRadius.r24),
          boxShadow: [AppShadow.soft.copyWith(offset: const Offset(0, 4))],
        ),
        padding: padding ?? .all(AppSpacing.s24),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          spacing: spacing ?? AppSpacing.s18,
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.s12,
                    children: [
                      AppIcon.logoWordmark.icon(width: _logoWidth),
                      title,
                    ],
                  ),
                ),
                _CloseButton(onPressed: () => Navigator.of(context).pop()),
              ],
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.subL_4, shape: .circle),
      child: AppBaseButton(
        onPressed: onPressed,
        radius: AppRadius.r60,
        splashColor: AppColors.subL_3,
        child: Padding(
          padding: .all(AppSpacing.s8),
          child: AppIcon.close.icon(size: AppSize.s16),
        ),
      ),
    );
  }
}
