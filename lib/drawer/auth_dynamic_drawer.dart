import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import '../provider/drawer_items_provider.dart';

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerState = ref.watch(drawerProvider);

//     return Drawer(
//       child: ListView.builder(
//         itemCount: drawerState.items.length,
//         itemBuilder: (context, index) {
//           final item = drawerState.items[index];
//           return ListTile(
//             leading: Icon(item.icon),
//             title: Text(item.title),
//             onTap: () {
//               if (item.title == 'Logout') {
//                 ref.read(authProvider.notifier).logout();
//                 Beamer.of(context).beamToNamed('/login');
//               } else {
//                 Beamer.of(context).beamToNamed(item.route);
//               }
//               Navigator.of(context).pop();
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerManager = ref.watch(drawerManagerProvider);

//     return Drawer(
//       child: ListView.builder(
//         itemCount: drawerManager.drawerItems.length,
//         itemBuilder: (context, index) {
//           final item = drawerManager.drawerItems[index];
//           return ListTile(
//             leading: Icon(item.icon),
//             title: Text(item.title),
//             onTap: () {
//               if (item.title == 'Logout') {
//                 ref.read(authProvider.notifier).logout();
//                 Beamer.of(context).beamToNamed('/login');
//               } else {
//                 Beamer.of(context).beamToNamed(item.route);
//               }
//               Navigator.of(context).pop();
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerItemsAsync = ref.watch(authDrawerItemsProvider);
//     final authNotifier = ref.read(authProvider.notifier);

//     return Drawer(
//       child: drawerItemsAsync.when(
//         data: (items) => ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return ListTile(
//               leading: Icon(item.icon),
//               title: Text(item.title),
//               onTap: () {
//                 if (item.title == 'Logout') {
//                   // Defer the logout to avoid modifying provider during build phase
//                   Future.microtask(() {
//                     authNotifier.logout();
//                     // Beamer.of(context).beamToNamed('/login');
//                     ref.refresh(authDrawerItemsProvider);
//                   });
//                 }

//                 // if (item.title == 'Logout') {
//                 //   authNotifier.logout();
//                 // }
//                 Beamer.of(context).beamToNamed(item.route);
//                 Navigator.of(context).pop();
//               },
//             );
//           },
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('Error: $err')),
//       ),
//     );
//   }
// }

// import 'package:beamer/beamer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../provider/auth_provider.dart';
// import '../provider/drawer_items_provider.dart';

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerItemsAsync = ref.watch(authDrawerItemsProvider);
//     final authNotifier = ref.read(authProvider.notifier);

//     return Drawer(
//       child: drawerItemsAsync.when(
//         data: (items) => ListView.builder(
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             return ListTile(
//               leading: Icon(item.icon),
//               title: Text(item.title),
//               onTap: () {
//                 if (item.title == 'Logout') {
//                   Future.microtask(() {
//                     authNotifier.logout();
//                     Beamer.of(context).beamToNamed('/login');
//                   });
//                 } else {
//                   Beamer.of(context).beamToNamed(item.route);
//                 }
//                 Navigator.of(context).pop(); // Close the drawer

//                 // if (item.title == 'Logout') {
//                 //   // Defer the logout to avoid modifying provider during build phase
//                 //   Future.microtask(() {
//                 //     authNotifier.logout();
//                 //     // Beamer.of(context).beamToNamed('/login');
//                 //   });
//                 // }

//                 // // if (item.title == 'Logout') {
//                 // //   authNotifier.logout();
//                 // // }
//                 // Beamer.of(context).beamToNamed(item.route);
//                 // Navigator.of(context).pop();
//               },
//             );
//           },
//         ),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('Error: $err')),
//       ),
//     );
//   }
// // }

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerItems = ref.watch(authDrawerItemsProvider);
//     final authNotifier = ref.read(authProvider.notifier);

//     return Drawer(
//       child: ListView.builder(
//         itemCount: drawerItems.length,
//         itemBuilder: (context, index) {
//           final item = drawerItems[index];
//           return ListTile(
//             leading: Icon(item.icon),
//             title: Text(item.title),
//             onTap: () {
//               if (item.title == 'Logout') {
//                 authNotifier.logout();
//               }
//               Beamer.of(context).beamToNamed(item.route);
//               Navigator.of(context).pop(); // Close the drawer
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class AuthDynamicDrawer extends ConsumerWidget {
//   const AuthDynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerItems = ref.watch(combinedDrawerItemsProvider);
//     final authNotifier = ref.read(authProvider.notifier);

//     return Drawer(
//       child: ListView.builder(
//         itemCount: drawerItems.length,
//         itemBuilder: (context, index) {
//           final item = drawerItems[index];
//           return ListTile(
//             leading: Icon(item.icon),
//             title: Text(item.title),
//             onTap: () {
//               if (item.title == 'Logout') {
//                 authNotifier.logout();
//               }
//               Beamer.of(context).beamToNamed(item.route);
//               Navigator.of(context).pop(); // Close the drawer
//             },
//           );
//         },
//       ),
//     );
//   }
// }

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
