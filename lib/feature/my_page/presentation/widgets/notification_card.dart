import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentrella/core/enum/notification_status.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.status,
    required this.title,
    required this.message,
    required this.date,
    this.endDate,
    this.overdue,
  });

  /// 우산 반납 완료 알림
  const NotificationCard.returned({
    Key? key,
    required String title,
    required String message,
    required DateTime startDate,
    required DateTime endDate,
  }) : this(
         key: key,
         status: NotificationStatus.returned,
         title: title,
         message: message,
         date: startDate,
         endDate: endDate,
       );

  /// 우산 연체 알림
  const NotificationCard.overdue({
    Key? key,
    required String title,
    required String message,
    required DateTime startDate,
    required DateTime endDate,
    required Duration overdue,
  }) : this(
         key: key,
         status: NotificationStatus.overdue,
         title: title,
         message: message,
         date: startDate,
         endDate: endDate,
         overdue: overdue,
       );

  /// 서비스 안내 알림
  const NotificationCard.service({
    Key? key,
    required String message,
    required DateTime date,
  }) : this(
         key: key,
         status: NotificationStatus.service,
         title: '서비스 안내',
         message: message,
         date: date,
       );

  /// 문의 접수 알림
  const NotificationCard.inquiry({
    Key? key,
    required String message,
    required DateTime date,
  }) : this(
         key: key,
         status: NotificationStatus.inquiry,
         title: '문의 접수',
         message: message,
         date: date,
       );

  final NotificationStatus status;
  final String title;
  final String message;

  /// 알림 일자 (대여 알림의 경우 대여 시작 일자)
  final DateTime date;

  /// 반납(예정) 일자 — 대여 관련 알림에서만 사용
  final DateTime? endDate;
  final Duration? overdue;

  static final _formatter = DateFormat('yyyy-MM-dd HH:mm');

  bool get _isOverdue => status == NotificationStatus.overdue;

  (AppIcon, Color) get _leading => switch (status) {
    NotificationStatus.returned => (AppIcon.umbrellaFold, AppColors.primary),
    NotificationStatus.overdue => (AppIcon.umbrellaFlipped, AppColors.r_2),
    NotificationStatus.service => (AppIcon.alertOutline, AppColors.black),
    NotificationStatus.inquiry => (AppIcon.bubbleChat, AppColors.black),
  };

  /// (라벨, 배경색, 글자색)
  (String, Color, Color)? get _label => switch (status) {
    NotificationStatus.returned => ('반납 완료', AppColors.g_3, AppColors.g_2),
    NotificationStatus.overdue => ('연체됨', AppColors.r_3, AppColors.r_2),
    NotificationStatus.service || NotificationStatus.inquiry => null,
  };

  @override
  Widget build(BuildContext context) {
    final (icon, iconBackground) = _leading;
    final label = _label;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(AppRadius.r16),
        border: .all(color: AppColors.subL_3, width: 0.667),
        boxShadow: const [AppShadow.soft],
      ),
      padding: .symmetric(vertical: AppSpacing.s16, horizontal: AppSpacing.s12),
      child: Row(
        crossAxisAlignment: .start,
        spacing: AppSpacing.s16,
        children: [
          Container(
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: .circular(AppRadius.r8),
            ),
            padding: .all(AppSpacing.s8),
            child: icon.icon(size: AppSize.s12, color: AppColors.white),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.s10,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  spacing: AppSpacing.s8,
                  children: [
                    Text(title, style: AppTextStyle.body1),
                    _buildDate(),
                    if (endDate != null) _buildRentDuration(),
                  ],
                ),
                Text(
                  message,
                  style: AppTextStyle.content2.copyWith(
                    color: AppColors.subD_2,
                  ),
                ),
              ],
            ),
          ),

          if (label != null)
            Container(
              decoration: BoxDecoration(
                color: label.$2,
                borderRadius: .circular(AppRadius.r18),
              ),
              padding: .symmetric(
                horizontal: AppSpacing.s8,
                vertical: AppSpacing.s4,
              ),
              child: Text(
                label.$1,
                style: AppTextStyle.content4.copyWith(color: label.$3),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDate() {
    final style = AppTextStyle.content3.copyWith(color: AppColors.subL_2);

    return Row(
      spacing: AppSpacing.s12,
      children: [
        Text(_formatter.format(date), style: style),
        if (endDate != null) ...[
          Text('~', style: style),
          Text(
            _formatter.format(endDate!),
            style: style.copyWith(
              color: _isOverdue ? AppColors.r_2 : AppColors.primary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRentDuration() {
    final rent = endDate!.difference(date);
    final hours = rent.inHours % 24;
    final minutes = (rent.inMinutes % 60).toString().padLeft(2, '0');
    final style = AppTextStyle.caption3;

    return Row(
      spacing: AppSpacing.s8,
      children: [
        Text('대여 기간 (${rent.inDays}일 $hours:$minutes)', style: style),
        if (overdue != null)
          Text(
            '+ 연체 ${overdue!.inHours}시간',
            style: style.copyWith(color: AppColors.r_2),
          ),
      ],
    );
  }
}
