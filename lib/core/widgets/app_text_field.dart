import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/color/app_colors.dart';
import 'package:rentrella/core/theme/constants/app_radius.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.controller,
    this.prefix,
    this.prefixIcon,
    this.hint,
    this.focusNode,
    this.error,
    this.suffix,
    this.hide,
    this.hideChar,
  });

  final String? label;
  final Widget? prefix;
  final AppIcon? prefixIcon;
  final Widget? suffix;
  final String? hint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? error;
  final bool? hide;
  final String? hideChar;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() => _focused = _focusNode.hasFocus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    final hasError = widget.error != null;
    final hasPrefix = widget.prefixIcon != null || widget.prefix != null;

    final borderColor = hasError
        ? AppColors.r_1
        : _focused
        ? AppColors.primary
        : AppColors.subL_3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.s4,
      children: [
        if (widget.label != null)
          Text(widget.label!, style: AppTextStyle.content3),

        AnimatedContainer(
          duration: duration,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.r8),
            color: AppColors.white,
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: hasError ? AppColors.r_1 : AppColors.subL_3,
                blurRadius: 4,
                offset: Offset(0, hasError ? 1 : 4),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (hasPrefix)
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpacing.s16,
                    right: AppSpacing.s8,
                  ),
                  child:
                      widget.prefixIcon?.icon(size: AppSize.s12) ??
                      widget.prefix,
                ),
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  obscureText: widget.hide ?? false,
                  obscuringCharacter: widget.hideChar ?? '•',
                  style: AppTextStyle.content3,
                  controller: widget.controller,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: AppSpacing.s12,
                      horizontal: hasPrefix ? 0 : AppSpacing.s16,
                    ),
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: AppTextStyle.content3.copyWith(
                      color: AppColors.subL_1,
                    ),
                  ),
                ),
              ),
              if (widget.suffix != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.s8),
                  child: widget.suffix,
                ),
            ],
          ),
        ),

        if (hasError)
          Text(
            widget.error!,
            style: AppTextStyle.content2.copyWith(color: AppColors.r_2),
          ),
      ],
    );
  }
}
