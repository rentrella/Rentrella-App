import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';
import 'package:rentrella/core/widgets/buttons/submit_button.dart';
import 'package:rentrella/core/widgets/dialog/app_dialog.dart';

/// 문의하기 다이얼로그 (홈 · 마이페이지 공용)
class InquiryDialog extends StatefulWidget {
  const InquiryDialog({super.key, this.onSubmit});

  /// 입력한 문의 내용을 전달. 추후 API 연동 시 사용
  final ValueChanged<String>? onSubmit;

  static Future<void> show(
    BuildContext context, {
    ValueChanged<String>? onSubmit,
  }) => AppDialog.show(context, InquiryDialog(onSubmit: onSubmit));

  @override
  State<InquiryDialog> createState() => _InquiryDialogState();
}

class _InquiryDialogState extends State<InquiryDialog> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    widget.onSubmit?.call(_controller.text.trim());
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final enable = _controller.text.trim().isNotEmpty;

    return AppDialog(
      padding: .symmetric(horizontal: AppSpacing.s24, vertical: AppSpacing.s20),
      spacing: AppSpacing.s12,
      title: Text(
        '문의하기',
        style: AppTextStyle.title3.copyWith(
          color: AppColors.subD_1,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Text(
          '우산 대여, 반납, 서비스 이용 중 궁금한 내용을 남겨주세요.',
          style: AppTextStyle.content1.copyWith(
            color: AppColors.subL_1,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.s8,
          children: [
            Text(
              '문의 내용',
              style: AppTextStyle.caption3.copyWith(color: AppColors.subD_1),
            ),
            Container(
              height: AppSize.s100,
              decoration: BoxDecoration(
                color: AppColors.subL_4,
                borderRadius: .circular(AppRadius.r12),
                border: .all(color: AppColors.subL_3),
                boxShadow: [AppShadow.field.copyWith(blurRadius: 2)],
              ),
              padding: .symmetric(
                horizontal: AppSpacing.s12,
                vertical: AppSpacing.s8,
              ),
              child: TextField(
                controller: _controller,
                expands: true,
                maxLines: null,
                textAlignVertical: .top,
                style: AppTextStyle.content2,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: .zero,
                  border: InputBorder.none,
                  hintText: '문의할 내용을 입력해주세요.',
                  hintStyle: AppTextStyle.content2.copyWith(
                    color: AppColors.subL_1,
                  ),
                ),
              ),
            ),
          ],
        ),
        SubmitButton(title: '문의 제출하기', onPressed: enable ? _submit : null),
      ],
    );
  }
}
