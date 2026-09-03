import 'package:go_router/go_router.dart';
import 'package:rentrella/feature/home/presentation/home_screen.dart';

import 'app_route.dart';

class MainRoute extends GoRoute {
  MainRoute()
    : super(
        path: AppPath.mainPath,
        redirect: (context, state) {
          if (state.matchedLocation == AppPath.mainPath) {
            return '${AppPath.mainPath}${AppPath.home}';
          }
          return null;
        },
      );

  @override
  List<RouteBase> get routes => [
    GoRoute(path: AppPath.home, builder: (context, state) => const HomeScreen()),
  ];
}
