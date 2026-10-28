import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/constants/app_size.dart';
import 'package:rentrella/core/theme/icon/app_icon.dart';
import 'package:rentrella/core/widgets/app_text_field.dart';

/// 보기/숨기기 토글이 포함된 비밀번호 입력 필드
class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.onChanged,
    this.error,
    this.textInputAction,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? error;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      hint: widget.hint,
      prefixIcon: AppIcon.lock,
      controller: widget.controller,
      onChanged: widget.onChanged,
      error: widget.error,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      hide: _hide,
      suffix: IconButton(
        onPressed: () => setState(() => _hide = !_hide),
        icon: (_hide ? AppIcon.visibilityOff : AppIcon.visibility).icon(
          size: AppSize.s12,
        ),
      ),
    );
  }
}
