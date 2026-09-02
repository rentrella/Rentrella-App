import 'package:flutter/material.dart';
import 'package:rentrella/core/theme/constants/app_spacing.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/core/widgets/app_banner.dart';
import 'package:rentrella/core/widgets/base_scaffold.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBanner(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s24,
            vertical: AppSpacing.s16,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: .start,
                children: [
                  Text('회원가입', style: AppTextStyle.title1),
                  Text(
                    'Rentrella 계정으로 우산 대여 서비스를 이용하세요.',
                    style: AppTextStyle.body4,
                  ),
                ],
              ),
        
              Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.s4,
                children: [Text('이메일', style: AppTextStyle.content3)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
