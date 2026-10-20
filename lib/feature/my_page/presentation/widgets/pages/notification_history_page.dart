import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';
import 'package:rentrella/core/widgets/buttons/app_sub_button.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/notification_card.dart';

class NotificationHistoryPage extends StatefulWidget {
  const NotificationHistoryPage({super.key});

  @override
  State<NotificationHistoryPage> createState() =>
      _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  static const _sectionDecoration = BoxDecoration(color: AppColors.white);

  int total = 12;
  int unread = 2;

  int page = 1;
  int lastPage = 3;

  @override
  Widget build(BuildContext context) {
    final items = _MockData.items;

    return Column(
      crossAxisAlignment: .start,
      children: [
        AppSpacing.s24.gapH,

        Container(
          decoration: _sectionDecoration.copyWith(
            borderRadius: .only(topRight: .circular(AppRadius.r8)),
          ),
          padding: .all(AppSpacing.s8),
          child: Text('전체 알림 $total개', style: AppTextStyle.caption1),
        ),
        Expanded(
          child: Container(
            decoration: _sectionDecoration,
            padding: .only(
              top: AppSpacing.s12,
              left: AppSpacing.s12,
              right: AppSpacing.s12,
            ),
            child: Column(
              children: [
                Row(
                  spacing: AppSpacing.s12,
                  crossAxisAlignment: .end,
                  children: [
                    AppSubButton(label: '알림 전체 읽기', onPressed: () {}),
                    AppSubButton(label: '읽은 알림 전체 삭제', onPressed: () {}),

                    const Spacer(),

                    Row(
                      spacing: AppSpacing.s10,
                      crossAxisAlignment: .end,
                      children: [
                        Text('중', style: AppTextStyle.caption1),
                        Text(
                          '미확인 $unread개',
                          style: AppTextStyle.content2.copyWith(
                            color: AppColors.pD_2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                AppSpacing.s12.gapH,

                Expanded(
                  child: ListView.separated(
                    // 카드 그림자가 잘리지 않도록 여백 확보
                    padding: .only(bottom: AppSpacing.s4),
                    itemBuilder: (context, index) => items[index],
                    separatorBuilder: (context, index) => AppSpacing.s12.gapH,
                    itemCount: items.length,
                  ),
                ),
              ],
            ),
          ),
        ),

        _PageIndex(
          page: page,
          onPrev: page > 1 ? () => setState(() => page -= 1) : null,
          onNext: page < lastPage ? () => setState(() => page += 1) : null,
        ),
      ],
    );
  }
}

class _PageIndex extends StatelessWidget {
  const _PageIndex({
    required this.page,
    required this.onPrev,
    required this.onNext,
  });

  final int page;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      padding: .all(AppSpacing.s12),
      child: Row(
        mainAxisAlignment: .center,
        spacing: AppSpacing.s12,
        children: [
          _dot(onPrev),
          Text(
            '$page',
            style: AppTextStyle.caption1.copyWith(color: AppColors.primary),
          ),
          _dot(onNext),
        ],
      ),
    );
  }

  Widget _dot(VoidCallback? onPressed) => AppBaseButton(
    onPressed: onPressed,
    radius: AppRadius.r8,
    child: Container(
      width: AppSize.s8,
      height: AppSize.s8,
      decoration: BoxDecoration(
        shape: .circle,
        color: onPressed != null ? AppColors.primary : AppColors.subL_3,
      ),
    ),
  );
}

class _MockData {
  _MockData._();

  static final _start = DateTime(2026, 9, 7, 14, 22);

  static List<Widget> get items => [
    NotificationCard.returned(
      title: '우산 #01',
      message: '우산 #01을 성공적으로 반납했어요!',
      startDate: _start,
      endDate: _start.add(const Duration(days: 1, hours: 2, minutes: 30)),
    ),
    NotificationCard.overdue(
      title: '우산 #01',
      message: '우산 #01의 반납을 3시간 동안 지체했어요.\n패널티 ... 를 받을 예정이에요.',
      startDate: _start,
      endDate: _start.add(const Duration(days: 3, hours: 3)),
      overdue: const Duration(hours: 3),
    ),
    NotificationCard.service(message: '서비스 안내 내용 ...', date: _start),
    NotificationCard.inquiry(
      message: '문의 접수가 성공적으로 완료되었어요!\n좀 더 나은 서비스를 제공하기 위해 노력할게요.',
      date: _start,
    ),
    NotificationCard.overdue(
      title: '우산 #01',
      message: '우산 #01의 반납을 3시간 동안 지체했어요.\n패널티 ... 를 받을 예정이에요.',
      startDate: _start,
      endDate: _start.add(const Duration(days: 3, hours: 3)),
      overdue: const Duration(hours: 3),
    ),
  ];
}
