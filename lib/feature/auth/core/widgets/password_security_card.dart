import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/feature/auth/core/enum/security_level.dart';

class PasswordSecurityCard extends StatelessWidget {
  const PasswordSecurityCard({super.key, required this.level});

  final SecurityLevel level;

  @override
  Widget build(BuildContext context) {
    final Color color = switch (level) {
      SecurityLevel.low || SecurityLevel.middle => AppColors.r_2,
      SecurityLevel.high => AppColors.g_2,
    };

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: const [AppShadow.card],
        borderRadius: .circular(AppRadius.r8),
        border: .all(color: AppColors.subL_3, width: 1),
      ),
      padding: const .symmetric(
        horizontal: AppSpacing.s16,
        vertical: AppSpacing.s12,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.s8,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '비밀번호 안전도',
                style: AppTextStyle.content2.copyWith(color: AppColors.black),
              ),

              Text(level.label, style: AppTextStyle.content2.copyWith(color: color)),
            ],
          ),

          Row(
            spacing: AppSpacing.s4,
            children: .generate(SecurityLevel.values.length, (index) {
              final act =
                  index <=
                  SecurityLevel.values.indexWhere(
                    (element) => element == level,
                  );

              return Expanded(
                child: Container(
                  height: AppSize.s6,
                  decoration: BoxDecoration(
                    borderRadius: .circular(99),
                    color: act ? color : AppColors.subL_3,
                  ),
                ),
              );
            }),
          ),

          Text(
            '6~20자, 영문+숫자+특수문자 포함',
            style: AppTextStyle.content3.copyWith(color: AppColors.subD_4),
          ),
        ],
      ),
    );
  }
}
