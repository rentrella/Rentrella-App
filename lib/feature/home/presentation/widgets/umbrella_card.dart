import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/buttons/primary_button.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_status_chip.dart';
import 'package:rentrella/core/widgets/umbrella/umbrella_status_icon.dart';
import 'package:rentrella/feature/home/presentation/view_models/umbrella_view_model.dart';

class UmbrellaCard extends StatelessWidget {
  const UmbrellaCard._({
    required this.title,
    required this.content,
    required this.status,
  });

  factory UmbrellaCard.formMode(UmbrellaViewModel model) {
    final String title = '우산 #${NumberFormat('00').format(model.id)}';
    return switch (model.status) {
      UmbrellaStatus.ready => UmbrellaCard._(
        title: title,
        content: '현재 우산 대여가 가능해요.',
        status: model.status,
      ),
      UmbrellaStatus.rentingByMe => UmbrellaCard._(
        title: title,
        content: '현재 우산 대여중에 있어요.',
        status: model.status,
      ),
      UmbrellaStatus.rented => UmbrellaCard._(
        title: title,
        content: '${model.user}님께서 우산을 사용하고 있어요.',
        status: model.status,
      ),
      UmbrellaStatus.overdue => UmbrellaCard._(
        title: title,
        content: '${model.user}님의 반납이 지연되고 있어요.',
        status: model.status,
      ),
      UmbrellaStatus.overdueByMe => UmbrellaCard._(
        title: title,
        content: '우산을 반납하지 않아 연체 되었어요.',
        status: model.status,
      ),
      UmbrellaStatus.unavailable => UmbrellaCard._(
        title: title,
        content: '현재 우산 대여가 가능하지 않아요.',
        status: model.status,
      ),
      UmbrellaStatus.broken => UmbrellaCard._(
        title: title,
        content: '우산이 파손되어 사용할 수 없어요.',
        status: model.status,
      ),
    };
  }

  final String title;
  final String content;
  final UmbrellaStatus status;

  Color? get _btnColor => switch (status) {
    UmbrellaStatus.ready => AppColors.primary,
    UmbrellaStatus.rentingByMe => AppColors.g_2,
    UmbrellaStatus.overdueByMe => AppColors.r_2,
    _ => null,
  };

  String get _btnLabel => switch (status) {
    UmbrellaStatus.rentingByMe || UmbrellaStatus.overdueByMe => '반납하기',
    _ => '대여하기',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s180,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: .all(color: AppColors.subL_4, width: 1),
        borderRadius: .circular(AppRadius.r12),
        boxShadow: const [AppShadow.card],
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.s18),
        child: Column(
          spacing: AppSpacing.s8,
          crossAxisAlignment: .start,
          children: [
            Row(
              children: [
                UmbrellaStatusIcon.fromStatus(
                  status,
                  size: AppSize.s12,
                  pad: AppSpacing.s8,
                  radius: AppRadius.r8,
                ),

                const Spacer(),

                UmbrellaStatusChip.fromStatus(status),
              ],
            ),

            Text(title, style: AppTextStyle.title3),

            Expanded(
              child: Align(
                alignment: .topLeft,
                child: SizedBox(
                  width: .infinity,
                  child: Text(
                    content,
                    style: AppTextStyle.content3.copyWith(
                      color: AppColors.subL_1,
                    ),
                  ),
                ),
              ),
            ),

            PrimaryButton(
              onPressed: _btnColor != null ? () {} : null,
              label: _btnLabel,
              background: _btnColor,
            ),
          ],
        ),
      ),
    );
  }
}
