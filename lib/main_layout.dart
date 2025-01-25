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

// // import 'package:beamer/beamer.dart';
// // import 'package:beamer_example/routes.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // import 'dependencies/app_dependencies.dart';

// void main() {
//   // Create an instance of AppDependencies to inject globally
//   final appDependencies = AppDependencies();

//   runApp(
//     ProviderScope(
//       overrides: [
//         // Override the global appDependenciesProvider with the instance
//         appDependenciesProvider.overrideWithValue(appDependencies),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final container = ProviderScope.containerOf(context);
//     // final authNotifier = container.read(authProvider.notifier);

//     // Access the AppDependencies from the provider
//     final appDependencies = ref.watch(appDependenciesProvider);

//     // Create the Beamer router delegate using the injected dependencies
//     final routerDelegate = createRouterDelegate(appDependencies);

//     return MaterialApp.router(
//       routerDelegate: routerDelegate,
//       routeInformationParser: BeamerParser(),
//     );
//   }
// }
