import 'package:flutter/material.dart';
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
      body: Column(children: []),
    );
  }
}
