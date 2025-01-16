import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import '../provider/drawer_items_provider.dart';

class AuthDynamicDrawer extends ConsumerWidget {
  const AuthDynamicDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerItems = ref.watch(authDrawerItemsProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Drawer(
      child: ListView.builder(
        itemCount: drawerItems.length,
        itemBuilder: (context, index) {
          final item = drawerItems[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.title),
            onTap: () {
              if (item.title == 'Logout') {
                authNotifier.logout();
              }
              Beamer.of(context).beamToNamed(item.route);
              Navigator.of(context).pop(); // Close the drawer
            },
          );
        },
      ),
    );
  }
}
