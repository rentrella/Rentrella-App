import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/buttons/sub_elevated_button.dart';
import 'package:rentrella/core/widgets/buttons/submit_button.dart';
import 'package:rentrella/core/widgets/dialog/app_dialog.dart';

/// 로그아웃 확인 다이얼로그
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key, this.onLogout});

  final VoidCallback? onLogout;

  static Future<void> show(BuildContext context, {VoidCallback? onLogout}) =>
      AppDialog.show(context, LogoutDialog(onLogout: onLogout));

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: Text('로그아웃 하기', style: AppTextStyle.title2),
      children: [
        Text(
          'Rentrella 계정을 로그아웃 하시겠어요?',
          style: AppTextStyle.content2.copyWith(color: AppColors.subL_1),
        ),
        Row(
          spacing: AppSpacing.s10,
          children: [
            Expanded(
              child: SubElevatedButton(
                label: '돌아가기',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Expanded(
              child: SubmitButton(
                title: '로그아웃',
                onPressed: () {
                  Navigator.of(context).pop();
                  onLogout?.call();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
