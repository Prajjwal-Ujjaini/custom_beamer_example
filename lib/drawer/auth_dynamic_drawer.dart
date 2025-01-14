import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import '../provider/drawer_items_provider.dart';

class AuthDynamicDrawer extends ConsumerWidget {
  const AuthDynamicDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerItemsAsync = ref.watch(authDrawerItemsProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Drawer(
      child: drawerItemsAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () {
                if (item.title == 'Logout') {
                  // Defer the logout to avoid modifying provider during build phase
                  Future.microtask(() {
                    authNotifier.logout();
                    // Beamer.of(context).beamToNamed('/login');
                  });
                }

                // if (item.title == 'Logout') {
                //   authNotifier.logout();
                // }
                Beamer.of(context).beamToNamed(item.route);
                Navigator.of(context).pop();
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}



//  if (item.title == 'Logout') {
//                   authNotifier.logout();
//                   Beamer.of(context).beamToNamed('/login');
//                 } else {
//                   Beamer.of(context).beamToNamed(item.route);
//                 }