// import 'package:beamer/beamer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/drawer_items_provider.dart';

// class DynamicDrawer extends ConsumerWidget {
//   const DynamicDrawer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final drawerItemsAsync = ref.watch(drawerItemsProvider);

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
