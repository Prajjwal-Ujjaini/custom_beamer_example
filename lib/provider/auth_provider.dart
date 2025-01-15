import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dependencies/app_dependencies.dart';
import '../services/auth_service.dart';

class AuthState {
  final bool isAuthenticated;
  final String? userName;

  const AuthState({this.isAuthenticated = false, this.userName});

  AuthState copyWith({bool? isAuthenticated, String? userName}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier({required this.authService}) : super(const AuthState());

  Future<void> login(String username, String password) async {
    final isAuthenticated = await authService.authenticate(username, password);
    if (isAuthenticated) {
      state = state.copyWith(isAuthenticated: true, userName: username);
    } else {
      state = state.copyWith(isAuthenticated: false, userName: null);
    }
  }

  Future<void> logout() async {
    await authService.logoutFromServer();
    state = state.copyWith(isAuthenticated: false, userName: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.authNotifier;
});
