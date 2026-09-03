import 'package:flutter/material.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

void main() async {
  runApp(
    MaterialApp.router(
      theme: ThemeData(fontFamily: AppTextStyle.fontFamily),
      routerConfig: appRoute,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    ),
  );
}
