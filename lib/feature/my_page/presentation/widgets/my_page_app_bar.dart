import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';

import '../../../../core/theme/font/app_text_style.dart';

class MyPageAppBar extends StatelessWidget {
  const MyPageAppBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: AppColors.white),
          padding: .symmetric(
            horizontal: AppSpacing.s12,
            vertical: AppSpacing.s16,
          ),
          child: Row(
            children: [
              AppIcon.arrowBack.iconBtn(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
                size: AppSize.s16,
              ),

              AppSpacing.s24.gapW,

              Text('마이 페이지', style: AppTextStyle.title3),
            ],
          ),
        ),

        _TopTabBar(navigationShell: navigationShell),
      ],
    );
  }
}

class _TopTabBar extends StatefulWidget {
  const _TopTabBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<_TopTabBar> createState() => _TopTabBarState();
}

class _TopTabBarState extends State<_TopTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.subL_3)),
        boxShadow: [AppShadow.soft],
      ),
      padding: .all(AppSpacing.s4),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.subL_3,
          borderRadius: .circular(AppRadius.r12),
        ),
        padding: .all(AppSpacing.s4),
        child: Row(
          spacing: AppSpacing.s4,
          children: [
            Expanded(
              child: _Tab(
                label: '계정 정보 및 설정',
                shellIndex: 0,
                navigationShell: widget.navigationShell,
              ),
            ),
            Expanded(
              child: _Tab(
                label: '알림 내역',
                shellIndex: 1,
                navigationShell: widget.navigationShell,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.label,
    required this.shellIndex,
    required this.navigationShell,
  });

  final String label;
  final int shellIndex;

  final StatefulNavigationShell navigationShell;

  static final _decoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: .circular(AppRadius.r8),
    boxShadow: [AppShadow.soft.copyWith(color: AppColors.subL_2)],
  );

  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;

    final focused = currentIndex == shellIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: focused
          ? _decoration
          : _decoration.copyWith(color: Colors.transparent, boxShadow: []),
      child: AppBaseButton(
        onPressed: () {
          if (!focused) {
            navigationShell.goBranch(shellIndex);
          }
        },
        radius: AppRadius.r8,
        child: Padding(
          padding: .symmetric(vertical: AppSpacing.s8),
          child: Row(
            mainAxisAlignment: .center,
            children: [Text(label, style: AppTextStyle.caption3)],
          ),
        ),
      ),
    );
  }
}
