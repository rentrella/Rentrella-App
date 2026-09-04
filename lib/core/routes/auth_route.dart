import 'package:go_router/go_router.dart';
import 'package:rentrella/feature/auth/login/presentation/login_screen.dart';
import 'package:rentrella/feature/auth/password_change/presentation/password_change_screen.dart';
import 'package:rentrella/feature/auth/signup/presentation/signup_screen.dart';

import 'app_route.dart';

class AuthRoute extends GoRoute {
  AuthRoute()
    : super(
        path: AppRoutes.auth.path,
        redirect: (context, state) {
          if (state.uri.path == AppRoutes.auth.path) {
            return AppRoutes.login.fullPath;
          }
          return null;
        },
      );

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: AppRoutes.login.path,
      name: AppRoutes.login.name,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup.path,
      name: AppRoutes.signup.name,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: AppRoutes.passwordChange.path,
      name: AppRoutes.passwordChange.name,
      builder: (context, state) => const PasswordChangeScreen(),
    ),
  ];
}
