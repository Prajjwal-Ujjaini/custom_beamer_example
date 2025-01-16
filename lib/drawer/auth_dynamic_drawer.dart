import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import '../provider/drawer_items_provider.dart';

class AuthDynamicDrawer extends ConsumerWidget {
  const AuthDynamicDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the FutureProvider
    final drawerItemsAsyncValue = ref.watch(authDrawerItemsProvider);

    return Drawer(
      child: drawerItemsAsyncValue.when(
        // While the data is loading
        loading: () => const Center(child: CircularProgressIndicator()),

        // When there's an error
        error: (error, stackTrace) => Center(child: Text('Error: $error')),

        // When data is successfully fetched
        data: (drawerItems) {
          final authNotifier = ref.read(authProvider.notifier);

          return ListView.builder(
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
          );
        },
      ),
    );
  }
}
