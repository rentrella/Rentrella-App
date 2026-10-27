import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/base/app_base_button.dart';
import 'package:rentrella/core/widgets/buttons/app_sub_button.dart';
import 'package:rentrella/feature/my_page/bloc/notification_history/notification_history_bloc.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/notification_card.dart';

class NotificationHistoryPage extends StatelessWidget {
  const NotificationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          NotificationHistoryBloc(notificationRepository: context.read())
            ..add(const NotificationHistoryStarted()),
      child: const _NotificationHistoryView(),
    );
  }
}

class _NotificationHistoryView extends StatelessWidget {
  const _NotificationHistoryView();

  static const _sectionDecoration = BoxDecoration(color: AppColors.white);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NotificationHistoryBloc>();
    final state = context.watch<NotificationHistoryBloc>().state;
    final items = state.items;

    return Column(
      crossAxisAlignment: .start,
      children: [
        AppSpacing.s24.gapH,

        Container(
          decoration: _sectionDecoration.copyWith(
            borderRadius: .only(topRight: .circular(AppRadius.r8)),
          ),
          padding: .all(AppSpacing.s8),
          child: Text('전체 알림 ${state.total}개', style: AppTextStyle.caption1),
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
                    AppSubButton(
                      label: '알림 전체 읽기',
                      onPressed: () =>
                          bloc.add(const NotificationHistoryReadAllRequested()),
                    ),
                    AppSubButton(
                      label: '읽은 알림 전체 삭제',
                      onPressed: () => bloc.add(
                        const NotificationHistoryDeleteReadRequested(),
                      ),
                    ),

                    const Spacer(),

                    Row(
                      spacing: AppSpacing.s10,
                      crossAxisAlignment: .end,
                      children: [
                        Text('중', style: AppTextStyle.caption1),
                        Text(
                          '미확인 ${state.unread}개',
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
                    itemBuilder: (context, index) =>
                        NotificationCard.fromModel(items[index]),
                    separatorBuilder: (context, index) => AppSpacing.s12.gapH,
                    itemCount: items.length,
                  ),
                ),
              ],
            ),
          ),
        ),

        _PageIndex(
          page: state.page,
          onPrev: state.hasPrev
              ? () => bloc.add(NotificationHistoryPageChanged(state.page - 1))
              : null,
          onNext: state.hasNext
              ? () => bloc.add(NotificationHistoryPageChanged(state.page + 1))
              : null,
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
