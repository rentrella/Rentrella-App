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
    this.error,
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? error;

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
      error: widget.error,
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
