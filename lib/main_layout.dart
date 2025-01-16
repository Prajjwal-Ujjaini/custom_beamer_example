import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'bottomNavigationBar/app_bottom_navigation_bar.dart';

import 'drawer/auth_dynamic_drawer.dart';

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
      appBar: AppBar(
        title: const Text('Beamer + Riverpod Drawer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Beamer.of(context).beamToNamed('/cart');
            },
          ),
          IconButton(
            icon: const Icon(Icons.online_prediction_sharp),
            onPressed: () {
              Beamer.of(context).beamToNamed('/order');
            },
          ),
        ],
      ),
      drawer: AuthDynamicDrawer(),
      body: child,
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: currentIndex),
    );
  }
}
