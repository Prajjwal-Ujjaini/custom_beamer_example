import 'package:flutter/material.dart';

import 'bottomNavigationBar/app_bottom_navigation_bar.dart';

import 'drawer/dynamic_drawer.dart';

// MainLayout for persistent drawer and bottom navigation bar
class MainLayout extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Beamer Example')),
      // drawer: AppDrawer(),
      appBar: AppBar(title: const Text('Beamer + Riverpod Drawer')),
      drawer: DynamicDrawer(),
      body: child,
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: currentIndex),
    );
  }
}
