import 'package:go_router/go_router.dart';
import 'package:rentrella/core/routes/app_route.dart';
import 'package:rentrella/feature/my_page/presentation/screens/my_page_screen.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/pages/account_and_setting_page.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/pages/notification_history_page.dart';

class MyPageRoute extends StatefulShellRoute {
  MyPageRoute()
    : super.indexedStack(
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.accountAndSetting.path,
                name: AppRoutes.accountAndSetting.name,
                builder: (context, state) => const AccountAndSettingPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.notificationHistory.path,
                name: AppRoutes.notificationHistory.name,
                builder: (context, state) => const NotificationHistoryPage(),
              ),
            ],
          ),
        ],
        builder: (context, state, navigationShell) =>
            MyPageScreen(navigationShell: navigationShell),
      );
}
