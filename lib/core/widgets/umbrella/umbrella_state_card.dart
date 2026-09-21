import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/utils/date_utils.dart';
import 'package:rentrella/core/widgets/buttons/primary_button.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_status_chip.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_status_icon.dart';

class UmbrellaStateCard extends StatelessWidget {
  const UmbrellaStateCard({
    super.key,
    this.title,
    required this.content,
    this.duration,
    this.overdue,
    this.returnAction,
    this.bottom,
    required this.status,
  });

  const UmbrellaStateCard.ready({Key? key})
    : this(
        key: key,
        status: UmbrellaStatus.ready,
        content: '우산 대여가 가능해요!\n우산을 대여하면 반납까지의 남은 기간을 알려드릴게요.',
      );

  const UmbrellaStateCard.renting({
    Key? key,
    required String title,
    required VoidCallback returnAction,
    Widget? bottom,
    required (DateTime, DateTime) duration,
  }) : this(
         key: key,
         title: title,
         returnAction: returnAction,
         bottom: bottom,
         duration: duration,
         status: UmbrellaStatus.rentingByMe,
         content: '현재 우산을 대여하고 있어요.\n남은 대여 기간에 맞춰 제시간에 반납해 주세요.',
       );

  const UmbrellaStateCard.overdue({
    Key? key,
    required String title,
    required (DateTime, DateTime) duration,
    required Duration overdue,
    required VoidCallback returnAction,
  }) : this(
         key: key,
         title: title,
         duration: duration,
         overdue: overdue,
         status: UmbrellaStatus.overdue,
         returnAction: returnAction,
         content: '우산이 아직 반납되지 않았어요.\n연체 기간을 바탕으로 패널티가 부과될 예정이에요.',
       );

  const UmbrellaStateCard.unavailable({Key? key, String? reason})
    : this(
        key: key,
        status: UmbrellaStatus.unavailable,
        content: '${reason != null ? '$reason\n' : ''}우산을 대여할 수 없어요.',
      );

  final UmbrellaStatus status;
  final String? title;
  final String content;
  final (DateTime, DateTime)? duration;
  final Duration? overdue;
  final VoidCallback? returnAction;
  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    final btnColor = overdue != null ? AppColors.r_2 : AppColors.g_2;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: .circular(AppRadius.r16),
      ),
      child: Column(
        spacing: AppSpacing.s4,
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Text('현재 상태', style: AppTextStyle.title3),
              SizedBox(width: AppSpacing.s12),
              UmbrellaStatusChip.fromStatus(status),

              const Spacer(),

              if (returnAction != null)
                SizedBox(
                  width: AppSize.s120,
                  child: PrimaryButton(
                    onPressed: () {},
                    label: '반납하기',
                    background: btnColor,
                  ),
                ),
            ],
          ),

          if (title != null) SizedBox(height: AppSpacing.s18),

          Row(
            children: [
              Expanded(
                child: Column(
                  spacing: AppSpacing.s8,
                  crossAxisAlignment: .start,
                  children: [
                    if (title != null) Text(title!, style: AppTextStyle.title1),
                    Text(content, style: AppTextStyle.caption3),
                  ],
                ),
              ),

              SizedBox(width: AppSpacing.s12),

              UmbrellaStatusIcon.fromStatus(
                status,
                radius: AppRadius.r16,
                size: AppSize.s36,
                pad: AppSpacing.s18,
              ),
            ],
          ),

          if (duration != null)
            Padding(
              padding: .symmetric(vertical: AppSpacing.s12),
              child: _buildRentDuration(),
            ),

          ?bottom,
        ],
      ),
    );
  }

  Row _buildRentDuration() {
    // data
    final startD = duration!.$1;
    final endD = duration!.$2;
    final isOverdue = overdue != null;

    // design
    final style = AppTextStyle.content4;
    final formater = DateFormat('yyyy-MM-dd hh:mm');

    return Row(
      spacing: AppSpacing.s4,
      crossAxisAlignment: .end,
      children: [
        Text(
          formater.format(startD),
          style: style.copyWith(color: AppColors.subL_2),
        ),
        Text('~', style: style.copyWith(color: AppColors.subL_2)),
        Text(
          formater.format(endD),
          style: style.copyWith(
            color: isOverdue ? AppColors.r_2 : AppColors.g_2,
          ),
        ),
        // TODO 서버에서 넘겨주는 겂 보고 형식 결정
        Row(
          mainAxisSize: .min,
          children: [
            Text('(1일 1:30)', style: style),

            if (isOverdue)
              Text(
                '+${overdue!.inHours} 시간',
                style: style.copyWith(color: AppColors.r_2),
              ),
          ],
        ),
      ],
    );
  }
}

class UmbrellaOpenButton extends StatefulWidget {
  const UmbrellaOpenButton({
    super.key,
    required this.openAction,
    required this.closeAction,
  });

  final VoidCallback openAction;
  final VoidCallback closeAction;

  @override
  State<UmbrellaOpenButton> createState() => _UmbrellaOpenButtonState();
}

class _UmbrellaOpenButtonState extends State<UmbrellaOpenButton> {
  Timer? timer;
  int sec = 30;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timer.tick >= 30) {
          _pauseTimer();
          return;
        }
        setState(() {
          sec -= 1;
        });
      });
    });
  }

  void _pauseTimer() {
    setState(() {
      timer?.cancel();
      timer = null;
      sec = 30;
    });
  }

  @override
  Widget build(BuildContext context) {
    final opening = timer != null;

    return Row(
      children: [
        SizedBox(
          width: AppSize.s120,
          child: PrimaryButton(
            onPressed: () {
              if (opening) {
                _pauseTimer();
                widget.closeAction();
              } else {
                _startTimer();
                widget.openAction();
              }
            },
            label: opening ? '잠금요청' : '잠금해제',
            background: opening ? AppColors.subL_2 : AppColors.primary,
          ),
        ),

        const Spacer(),

        if (opening)
          Column(
            crossAxisAlignment: .end,
            spacing: AppSpacing.s2,
            children: [
              Text(
                '자동 잠금까지',
                style: AppTextStyle.content4.copyWith(color: AppColors.r_2),
              ),
              Text(
                '$sec초',
                style: AppTextStyle.content4.copyWith(color: AppColors.r_2),
              ),
            ],
          ),
      ],
    );
  }
}
