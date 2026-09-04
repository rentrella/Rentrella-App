import 'package:go_router/go_router.dart';
import 'package:rentrella/feature/home/presentation/home_screen.dart';

import 'app_route.dart';

class MainRoute extends GoRoute {
  MainRoute()
    : super(
        path: AppRoutes.main.path,
        redirect: (context, state) {
          if (state.uri.path == AppRoutes.main.path) {
            return AppRoutes.home.fullPath;
          }
          return null;
        },
      );

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.main.name,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}
