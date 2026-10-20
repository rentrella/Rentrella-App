import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/widgets/dialog/inquiry_dialog.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/dialogs/logout_dialog.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/dialogs/notification_setting_dialog.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_state_card.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/my_page_button_tile.dart';

class AccountAndSettingPage extends StatelessWidget {
  const AccountAndSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: AppSpacing.s16, vertical: AppSpacing.s24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: .circular(AppRadius.r18),
              boxShadow: [AppShadow.card.copyWith(offset: const Offset(0, 4))],
            ),
            padding: .symmetric(
              horizontal: AppSpacing.s16,
              vertical: AppSpacing.s24,
            ),
            child: Column(
              spacing: AppSpacing.s12,
              children: [
                const _Profile(),
                _divider(),
                const UmbrellaStateCard.ready(),
                _divider(),

                Column(
                  spacing: AppSpacing.s12,
                  children: [
                    MyPageButtonTile(
                      icon: .bubbleChatNew,
                      label: '문의하기',
                      onPressed: () => InquiryDialog.show(context),
                    ),
                    MyPageButtonTile(
                      icon: .bell,
                      label: '알림설정',
                      onPressed: () => NotificationSettingDialog.show(
                        context,
                        allowed: true,
                      ),
                    ),
                    MyPageButtonTile(
                      icon: .lock,
                      label: '비밀번호 변경',
                      onPressed: () =>
                          context.pushNamed(AppRoutes.passwordChange.name),
                    ),
                  ],
                ),
              ],
            ),
          ),

          AppSpacing.s10.gapH,

          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: .circular(AppRadius.r12),
              boxShadow: [
                AppShadow.soft.copyWith(
                  color: AppColors.r_2,
                  offset: const Offset(0, 0.5),
                ),
              ],
            ),
            clipBehavior: .antiAlias,
            child: AppBaseButton(
              onPressed: () => LogoutDialog.show(
                context,
                onLogout: () => context.goNamed(AppRoutes.login.name),
              ),
              radius: AppRadius.r12,
              child: Padding(
                padding: .symmetric(
                  horizontal: AppSpacing.s24,
                  vertical: AppSpacing.s16,
                ),
                child: Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      '로그아웃',
                      style: AppTextStyle.button1.copyWith(
                        color: AppColors.r_2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider({EdgeInsets? padding}) => Padding(
    padding: padding ?? .all(AppSpacing.s8),
    child: const Divider(color: AppColors.subL_4, height: 1, thickness: 1),
  );
}

class _Profile extends StatelessWidget {
  const _Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppSpacing.s8,
      children: [
        Container(
          width: AppSize.s64,
          height: AppSize.s64,
          decoration: const BoxDecoration(
            shape: .circle,
            color: AppColors.subL_3,
          ),
          alignment: .center,
          child: Text(
            'U',
            style: AppTextStyle.h1.copyWith(color: AppColors.white),
          ),
        ),
        Expanded(
          child: Column(
            spacing: AppSpacing.s4,
            crossAxisAlignment: .start,
            children: [
              Text('{{이름}}', style: AppTextStyle.title3),
              Text(
                '{학년} {반} {번호}',
                style: AppTextStyle.content4.copyWith(color: AppColors.subD_2),
              ),
              Text(
                '역할 : {역할}',
                style: AppTextStyle.content4.copyWith(color: AppColors.subD_2),
              ),

              AppSpacing.s2.gapH,

              Text(
                '{이메일}',
                style: AppTextStyle.content4.copyWith(color: AppColors.subL_2),
              ),
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: .circular(AppRadius.r32),
            color: AppColors.subL_5,
          ),
          padding: .symmetric(
            vertical: AppSpacing.s8,
            horizontal: AppSpacing.s12,
          ),
          child: Text(
            '{{가입일자 yyyy:MM:dd}}',
            style: AppTextStyle.content5.copyWith(color: AppColors.subD_2),
          ),
        ),
      ],
    );
  }
}
