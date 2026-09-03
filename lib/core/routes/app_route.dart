import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/main_route.dart';

import 'auth_route.dart';

final appRoute = GoRouter(
  initialLocation: '${AppPath.authPath}${AppPath.login}',
  routes: [AuthRoute(), MainRoute()],
);

class AppPath {
  /// section
  static const authPath = '/auth';
  static const mainPath = '/main';

  /// auth
  static const login = '/login';
  static const signup = '/signup';
  static const passwordChange = '/password_change';

  /// main
  static const home = '/home';
}
