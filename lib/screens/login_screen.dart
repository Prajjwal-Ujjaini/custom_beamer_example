import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await authNotifier.login('username', 'password');
            await authNotifier.login('admin', 'password');
            Beamer.of(context).beamToNamed('/home');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
