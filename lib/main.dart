import 'package:beamer/beamer.dart';
import 'package:beamer_example/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/auth_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final container = ProviderScope.containerOf(context);
    final authNotifier = container.read(authProvider.notifier);

    final routerDelegate = createRouterDelegate(authNotifier);

    return MaterialApp.router(
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerParser(),
    );
  }
}
