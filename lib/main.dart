import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';
import 'package:rentrella/feature/auth/core/data/repositories/mock_auth_repository.dart';
import 'package:rentrella/feature/home/data/repositories/mock_umbrella_repository.dart';
import 'package:rentrella/feature/home/data/repositories/mock_weather_repository.dart';
import 'package:rentrella/feature/home/data/repositories/umbrella_repository.dart';
import 'package:rentrella/feature/home/data/repositories/weather_repository.dart';
import 'package:rentrella/feature/my_page/data/repositories/mock_notification_repository.dart';
import 'package:rentrella/feature/my_page/data/repositories/notification_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([.portraitDown, .portraitUp]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // 서버 연동 시 Mock 구현체만 실제 구현체로 교체한다.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => MockAuthRepository()),
        RepositoryProvider<UmbrellaRepository>(
          create: (_) => MockUmbrellaRepository(),
        ),
        RepositoryProvider<WeatherRepository>(
          create: (_) => MockWeatherRepository(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (_) => MockNotificationRepository(),
        ),
      ],
      child: ScreenUtilInit(
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
}
