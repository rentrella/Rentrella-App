import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/main_route.dart';

import 'auth_route.dart';

final appRoute = GoRouter(
  initialLocation: AppRoutes.login.fullPath,
  routes: [AuthRoute(), MainRoute()],
);

/// section

enum AppRoutes {
  /// section
  auth('/auth', 'auth'),
  main('/main', 'main'),

  /// auth
  login('login', 'login'),
  signup('signup', 'signup'),
  passwordChange('password_change', 'password_change'),

  /// main
  home('home', 'home');

  final String path;
  final String name;

  const AppRoutes(this.path, this.name);

  String get fullPath => switch (this) {
    login || signup || passwordChange => '${auth.path}/$path',
    home => '${main.path}/$path',
    auth || main => path,
  };
}
