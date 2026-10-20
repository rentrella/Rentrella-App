import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/buttons/sub_elevated_button.dart';
import 'package:rentrella/core/widgets/dialog/app_dialog.dart';

/// 알림 허용/거부 설정 다이얼로그
class NotificationSettingDialog extends StatefulWidget {
  const NotificationSettingDialog({
    super.key,
    required this.allowed,
    this.onChanged,
  });

  final bool allowed;
  final ValueChanged<bool>? onChanged;

  static Future<void> show(
    BuildContext context, {
    required bool allowed,
    ValueChanged<bool>? onChanged,
  }) => AppDialog.show(
    context,
    NotificationSettingDialog(allowed: allowed, onChanged: onChanged),
  );

  @override
  State<NotificationSettingDialog> createState() =>
      _NotificationSettingDialogState();
}

class _NotificationSettingDialogState extends State<NotificationSettingDialog> {
  late bool _allowed = widget.allowed;

  void _select(bool value) {
    if (value == _allowed) return;
    setState(() => _allowed = value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: Text('알림 설정', style: AppTextStyle.title2),
      children: [
        Text(
          'Rentrella 사이트를 이용하면서\n서비스 소식/우산 대여 및 반납과 관련한 알림을 받습니다.',
          style: AppTextStyle.content2.copyWith(color: AppColors.subL_1),
        ),
        Row(
          spacing: AppSpacing.s10,
          children: [
            Expanded(
              child: SubElevatedButton(
                label: '알림 허용',
                onPressed: () => _select(true),
                trailing: _RadioMark(selected: _allowed),
              ),
            ),
            Expanded(
              child: SubElevatedButton(
                label: '알림 거부',
                onPressed: () => _select(false),
                trailing: _RadioMark(selected: !_allowed),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Material 3 라디오 버튼 모양 표시 (20 × 20)
class _RadioMark extends StatelessWidget {
  const _RadioMark({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.subL_1;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: AppSize.s20,
      height: AppSize.s20,
      decoration: BoxDecoration(
        shape: .circle,
        border: .all(color: color, width: 2),
      ),
      alignment: .center,
      child: selected
          ? Container(
              width: AppSize.s8,
              height: AppSize.s8,
              decoration: BoxDecoration(shape: .circle, color: color),
            )
          : null,
    );
  }
}
