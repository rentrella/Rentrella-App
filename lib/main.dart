import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([.portraitDown, .portraitUp]);

  runApp(
    ScreenUtilInit(
      designSize: const Size(402, 872),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          theme: ThemeData(fontFamily: AppTextStyle.fontFamily),
          routerConfig: appRoute,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    ),
  );
}
