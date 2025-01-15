import 'package:beamer/beamer.dart';
import 'package:beamer_example/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dependencies/app_dependencies.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final container = ProviderScope.containerOf(context);
    // final authNotifier = container.read(authProvider.notifier);
    // Access the AppDependencies from the provider
    final appDependencies = ref.watch(appDependenciesProvider);

    // Create the Beamer router delegate using the injected dependencies
    final routerDelegate = createRouterDelegate(appDependencies);

    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
