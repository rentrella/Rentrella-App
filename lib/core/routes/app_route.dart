import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/main_route.dart';
import 'package:rentrella/feature/splash/presentation/screens/splash_screen.dart';

import 'auth_route.dart';

final appRoute = GoRouter(
  initialLocation: AppRoutes.splash.fullPath,
  routes: [
    GoRoute(
      path: AppRoutes.splash.path,
      name: AppRoutes.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    AuthRoute(),
    MainRoute(),
  ],
);

enum AppRoutes {
  /// splash
  splash('/splash', 'SPLASH'),

  /// section
  auth('/auth', 'AUTH'),
  main('/main', 'MAIN'),

  /// auth
  login('login', 'LOGIN'),
  signup('signup', 'SIGNUP'),
  passwordChange('password_change', 'PASSWORD_CHANGE'),

  /// main
  home('home', 'HOME'),
  accountAndSetting('account_and_setting', 'ACCOUNT_AND_SETTING'),
  notificationHistory('notification_history', 'NOTIFICATION_HISTORY');

  final String path;
  final String name;

  const AppRoutes(this.path, this.name);

  String get fullPath => switch (this) {
    login || signup || passwordChange => '${auth.path}/$path',
    home || accountAndSetting || notificationHistory => '${main.path}/$path',
    splash || auth || main => path,
  };
}
