import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rentrella/core/network/api_client.dart';
import 'package:rentrella/core/network/api_config.dart';
import 'package:rentrella/core/network/token_storage.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/core/theme/font/app_text_style.dart';
import 'package:rentrella/feature/auth/core/data/repositories/api_auth_repository.dart';
import 'package:rentrella/feature/auth/core/data/repositories/auth_repository.dart';
import 'package:rentrella/feature/auth/core/data/repositories/mock_auth_repository.dart';
import 'package:rentrella/feature/home/data/repositories/api_umbrella_repository.dart';
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
  const App({super.key, this.useMock = ApiConfig.useMock});

  /// true면 서버 대신 Mock 리포지토리 (`--dart-define=USE_MOCK=true`, 테스트)
  final bool useMock;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: useMock ? _mockRepositories() : _apiRepositories(),
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

List<RepositoryProvider> _mockRepositories() => [
  RepositoryProvider<AuthRepository>(create: (_) => MockAuthRepository()),
  RepositoryProvider<UmbrellaRepository>(
    create: (_) => MockUmbrellaRepository(),
  ),
  RepositoryProvider<WeatherRepository>(create: (_) => MockWeatherRepository()),
  RepositoryProvider<NotificationRepository>(
    create: (_) => MockNotificationRepository(),
  ),
];

/// 서버 미구현 기능(날씨·알림)은 Mock을 유지한다.
List<RepositoryProvider> _apiRepositories() => [
  RepositoryProvider<TokenStorage>(create: (_) => SecureTokenStorage()),
  RepositoryProvider<Dio>(
    create: (context) => createApiClient(
      tokenStorage: context.read(),
      onSessionExpired: () => appRoute.goNamed(AppRoutes.login.name),
    ),
  ),
  RepositoryProvider<AuthRepository>(
    create: (context) =>
        ApiAuthRepository(dio: context.read(), tokenStorage: context.read()),
  ),
  RepositoryProvider<UmbrellaRepository>(
    create: (context) => ApiUmbrellaRepository(dio: context.read()),
  ),
  RepositoryProvider<WeatherRepository>(create: (_) => MockWeatherRepository()),
  RepositoryProvider<NotificationRepository>(
    create: (_) => MockNotificationRepository(),
  ),
];
