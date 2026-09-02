import 'package:go_router/go_router.dart';
import 'package:rentrella/feature/auth/login/presentation/login_screen.dart';
import 'package:rentrella/feature/auth/password_change/presentation/password_change_screen.dart';
import 'package:rentrella/feature/auth/signup/presentation/signup_screen.dart';

import 'app_route.dart';

class AuthRoute extends GoRoute {
  AuthRoute()
    : super(
        path: AppPath.authPath,
        redirect: (context, state) {
          if (state.matchedLocation == AppPath.authPath) {
            return '${AppPath.authPath}${AppPath.login}';
          }
          return null;
        },
      );

  @override
  List<RouteBase> get routes => [
    GoRoute(path: AppPath.login, builder: (context, state) => LoginScreen()),
    GoRoute(path: AppPath.signup, builder: (context, state) => SignupScreen()),
    GoRoute(
      path: AppPath.passwordChange,
      builder: (context, state) => PasswordChangeScreen(),
    ),
  ];
}
