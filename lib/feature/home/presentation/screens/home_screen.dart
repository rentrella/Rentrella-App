import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/app_banner.dart';
import 'package:rentrella/core/widgets/app_divider.dart';
import 'package:rentrella/core/widgets/app_sub_button.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_state_card.dart';
import 'package:rentrella/feature/home/widgets/app_icon_button.dart';
import 'package:rentrella/feature/home/widgets/weather_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: AppColors.white,
      appBar: const AppBanner(suffix: _Profile()),
      body: Padding(
        padding: .symmetric(
          horizontal: AppSpacing.s16,
          vertical: AppSpacing.s24,
        ),
        child: Column(
          spacing: AppSpacing.s24,
          children: [
            const WeatherBanner(),
            Column(
              spacing: AppSpacing.s8,
              children: const [
                AppDivider(pad: .all(8)),
                UmbrellaStateCard.ready(),
                AppDivider(pad: .all(8)),
              ],
            ),

            Column(
              children: [
                Row(
                  children: [
                    Text(
                      '우산 목록',
                      style: AppTextStyle.title3.copyWith(
                        color: AppColors.subD_2,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      '총 12개 중 9개 가능',
                      style: AppTextStyle.content2.copyWith(
                        color: AppColors.subD_3,
                      ),
                    ),
                  ],
                ),

                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => ,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Profile extends StatefulWidget {
  const _Profile({super.key});

  @override
  State<_Profile> createState() => _ProfileState();
}

class _ProfileState extends State<_Profile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('{이름}님', style: AppTextStyle.content1),
            Text('환영합니다', style: AppTextStyle.content5),

            SizedBox(height: AppSpacing.s8),

            Row(
              spacing: AppSpacing.s4,
              children: [
                AppSubButton(title: '문의하기', onPressed: () {}),
                AppSubButton(title: '"마이페이지"로 이동', onPressed: () {}),
              ],
            ),
          ],
        ),

        SizedBox(width: AppSize.s12),

        AppIconButton(onPressed: () {}, icon: .bell),
      ],
    );
  }
}
