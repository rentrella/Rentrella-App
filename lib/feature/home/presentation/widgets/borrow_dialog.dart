import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/buttons/sub_elevated_button.dart';
import 'package:rentrella/core/widgets/buttons/submit_button.dart';
import 'package:rentrella/core/widgets/dialog/app_dialog.dart';

/// 우산 대여 확인 다이얼로그
class BorrowDialog extends StatelessWidget {
  const BorrowDialog({super.key, required this.umbrella, this.onBorrow});

  /// 우산 이름 (예: 우산 #01)
  final String umbrella;
  final VoidCallback? onBorrow;

  static Future<void> show(
    BuildContext context, {
    required String umbrella,
    VoidCallback? onBorrow,
  }) => AppDialog.show(
    context,
    BorrowDialog(umbrella: umbrella, onBorrow: onBorrow),
  );

  @override
  Widget build(BuildContext context) {
    final subStyle = AppTextStyle.caption3.copyWith(color: AppColors.subL_1);

    return AppDialog(
      title: Text('우산 대여하기', style: AppTextStyle.title1),
      children: [
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.s8,
          children: [
            Row(
              crossAxisAlignment: .end,
              spacing: AppSpacing.s10,
              children: [
                Text(
                  umbrella,
                  style: AppTextStyle.title3.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('를 대여하시겠어요?', style: subStyle),
              ],
            ),
            Text('분실 시 변상 책임이 있습니다.', style: subStyle),
          ],
        ),
        Row(
          spacing: AppSpacing.s10,
          children: [
            Expanded(
              child: SubElevatedButton(
                label: '취소',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: SubmitButton(
                title: '대여하기',
                onPressed: () {
                  Navigator.of(context).pop();
                  onBorrow?.call();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
