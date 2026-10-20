import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

/// 화면 하단 버튼 영역 위에 붙는 에러 배너 (Error | 메시지)
///
/// [message]가 null이면 접혀서 보이지 않는다.
class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({super.key, required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: .bottomCenter,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.r_3,
                border: Border.symmetric(
                  horizontal: BorderSide(color: AppColors.r_2, width: 0.5),
                ),
              ),
              padding: .symmetric(
                horizontal: AppSpacing.s16,
                vertical: AppSpacing.s8,
              ),
              child: Row(
                spacing: AppSpacing.s8,
                children: [
                  AppIcon.alert.icon(size: AppSize.s16, color: AppColors.r_2),
                  Text(
                    'Error',
                    style: AppTextStyle.body4.copyWith(color: AppColors.r_2),
                  ),
                  Container(
                    width: 1,
                    height: AppSize.s16,
                    color: AppColors.subD_4,
                  ),
                  Expanded(child: Text(message!, style: AppTextStyle.content1)),
                ],
              ),
            ),
    );
  }
}
