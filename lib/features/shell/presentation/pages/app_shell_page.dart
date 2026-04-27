import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_wallet/features/shell/presentation/controllers/app_shell_controller.dart';
import 'package:mini_wallet/routes/route_paths.dart';

class AppShellPage extends GetView<AppShellController> {
  const AppShellPage({super.key, required this.child});

  final Widget child;

  int _getCurrentIndex(String path) {
    if (path == RoutePaths.addTransaction) {
      return 1;
    }

    if (path == RoutePaths.editTransaction) {
      return 2;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    final currentIndex = _getCurrentIndex(currentPath);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 0) {
            context.go(RoutePaths.home);
            return;
          }

          if (index == 1) {
            context.go(RoutePaths.addTransaction);
            return;
          }

          context.go(RoutePaths.editTransaction);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_outlined),
            activeIcon: Icon(Icons.edit),
            label: 'Edit',
          ),
        ],
      ),
    );
  }
}
