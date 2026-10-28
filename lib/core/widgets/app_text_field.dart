import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/theme/shadow/app_shadow.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.prefixIcon,
    this.hint,
    this.focusNode,
    this.error,
    this.suffix,
    this.hide,
    this.hideChar,
    this.action,
    this.textInputAction,
    this.onSubmitted,
  });

  final String? label;
  final AppIcon? prefixIcon;
  final Widget? suffix;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final String? error;
  final bool? hide;
  final String? hideChar;
  final Widget? action;

  /// 키보드 엔터 동작. `next`면 다음 입력칸으로 이동한다.
  final TextInputAction? textInputAction;

  /// 엔터(`done` 등) 입력 시 콜백 (예: 폼 제출)
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  BoxDecoration _buildDecoration() {
    final isErr = widget.error != null;
    final borderColor = isErr
        ? AppColors.r_1
        : _focusNode.hasFocus
        ? AppColors.primary
        : AppColors.subL_3;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      color: AppColors.white,
      border: .all(color: borderColor, width: 1.2),
      boxShadow: [
        isErr
            ? AppShadow.field.copyWith(color: AppColors.r_1)
            : AppShadow.field,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s4,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: AppTextStyle.content2),
        Row(
          spacing: AppSpacing.s8,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _focusNode.requestFocus,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: _buildDecoration(),
                      padding: EdgeInsets.only(
                        left: AppSpacing.s16,
                        top: AppSpacing.s12,
                        bottom: AppSpacing.s12,
                        right: widget.suffix != null
                            ? AppSpacing.s40
                            : AppSpacing.s16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: AppSpacing.s8,
                        children: [
                          if (widget.prefixIcon != null)
                            widget.prefixIcon!.icon(size: AppSize.s12),
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              obscureText: widget.hide ?? false,
                              obscuringCharacter: widget.hideChar ?? '•',
                              style: AppTextStyle.content2,
                              controller: widget.controller,
                              onChanged: widget.onChanged,
                              textInputAction: widget.textInputAction,
                              onSubmitted: widget.onSubmitted,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: .zero,
                                border: InputBorder.none,
                                hintText: widget.hint,
                                hintStyle: AppTextStyle.content2.copyWith(
                                  color: AppColors.subL_1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.suffix != null)
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        // 엔터(next) 이동 시 버튼을 건너뛰고 다음 입력칸으로 간다.
                        child: ExcludeFocusTraversal(
                          child: Center(child: widget.suffix!),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            if (widget.action != null)
              ExcludeFocusTraversal(child: widget.action!),
          ],
        ),
        if (widget.error != null)
          Text(
            widget.error!,
            style: AppTextStyle.content2.copyWith(color: AppColors.r_2),
          ),
      ],
    );
  }
}
