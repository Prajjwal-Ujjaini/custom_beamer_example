import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

import '../services/auth_service.dart';

class AppDependencies {
  final AuthService authService;
  final AuthNotifier authNotifier;

  AppDependencies()
      : authService = AuthService(),
        authNotifier = AuthNotifier(authService: AuthService());
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  return AppDependencies();
});
