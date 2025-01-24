import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider((ref) => const FlutterSecureStorage());
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final storage = ref.watch(secureStorageProvider);
  return AuthNotifier(storage);
});

class AuthNotifier extends StateNotifier<bool> {
  final FlutterSecureStorage _storage;

  AuthNotifier(this._storage) : super(false) {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await _storage.read(key: 'auth_token');
    state = token != null;
  }

  Future<void> login(String token) async {
    try {
      await _storage.write(key: 'auth_token', value: token);
      state = true;
    } catch (e) {
      throw Exception('Login failed: Unable to store token');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    state = false;
  }
}

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authInitialization = ref.watch(authInitializationProvider);

    return MaterialApp.router(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // System-based dark/light theme
      routerDelegate: BeamerDelegate(
        initialPath: '/splash',
        locationBuilder: RoutesLocationBuilder(
          routes: {
            '/splash': (context, state, data) => SplashScreen(),
            '/login': (context, state, data) => LoginPage(),
            '/dashboard': (context, state, data) => DashboardPage(),
            '/settings': (context, state, data) => SettingsPage(),
            '/profile': (context, state, data) => ProfilePage(),
          },
        ),
        guards: [
          BeamGuard(
            pathPatterns: ['/dashboard', '/settings', '/profile'],
            check: (context, location) =>
                ref.read(authProvider), // Only allow if authenticated
            onCheckFailed: (context, location) =>
                Beamer.of(context).beamToNamed('/login'),
          ),
          BeamGuard(
            pathPatterns: ['/login', '/splash'],
            check: (context, location) => !ref
                .read(authProvider), // Redirect logged-in users to dashboard
            onCheckFailed: (context, location) =>
                Beamer.of(context).beamToNamed('/dashboard'),
          ),
        ],
      ),
      routeInformationParser: BeamerParser(),
      builder: (context, child) {
        if (authInitialization is AsyncLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (authInitialization is AsyncError) {
          return Center(child: Text('Error initializing app'));
        }
        return child!;
      },
    );
  }
}

final authInitializationProvider = FutureProvider<bool>((ref) async {
  final authNotifier = ref.read(authProvider.notifier);
  await authNotifier._checkAuthStatus();
  return true;
});

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(authProvider, (_, isLoggedIn) {
      if (isLoggedIn) {
        Beamer.of(context).beamToNamed('/dashboard');
      } else {
        Beamer.of(context).beamToNamed('/login');
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://storage.googleapis.com/cms-storage-bucket/d406c736e7c4c57f5f61.png',
              width: 150,
            ),
            SizedBox(height: 20),
            Text('Welcome to the App!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await ref.read(authProvider.notifier).login('dummy_token');
              Beamer.of(context).beamToNamed('/dashboard');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login failed: ${e.toString()}')),
              );
            }
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}

class DashboardPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              Beamer.of(context).beamToNamed('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Dashboard!', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                Beamer.of(context).beamToNamed('/settings');
              },
              child: Text('Go to Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                Beamer.of(context).beamToNamed('/profile');
              },
              child: Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Text('Settings Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text('Profile Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
