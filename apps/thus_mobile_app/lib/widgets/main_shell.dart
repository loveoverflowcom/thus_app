import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final class MainShell extends StatelessWidget {
  const MainShell({required this.child, super.key});

  final Widget child;

  static const _tabs = [
    (label: 'Home', icon: Icons.chat_bubble_outline, path: '/'),
    (label: 'Personal', icon: Icons.person_outline, path: '/personal'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _tabs.indexWhere((t) => t.path == location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex < 0 ? 0 : currentIndex,
        onDestinationSelected: (index) =>
            context.go(_tabs[index].path),
        destinations: _tabs
            .map(
              (t) => NavigationDestination(
                icon: Icon(t.icon),
                label: t.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
