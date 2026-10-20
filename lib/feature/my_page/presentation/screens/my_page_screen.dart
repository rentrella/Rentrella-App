import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rentrella/core/widgets/base/base_scaffold.dart';
import 'package:rentrella/feature/my_page/presentation/widgets/my_page_app_bar.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: MyPageAppBar(navigationShell: navigationShell),
      body: navigationShell,
    );
  }
}
