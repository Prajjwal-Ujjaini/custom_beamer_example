import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  AuthNotifier() : super(const AuthState());

  void login(String userName) {
    state = state.copyWith(isAuthenticated: true, userName: userName);
  }

  void logout() {
    state = state.copyWith(isAuthenticated: false, userName: null);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
