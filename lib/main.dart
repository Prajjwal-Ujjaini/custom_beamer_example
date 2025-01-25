import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Step 1: Create AppDependencies to manage all services and notifiers
class AppDependencies {
  final FlutterSecureStorage secureStorage;
  final AuthNotifier authNotifier;

  AppDependencies()
      : secureStorage = const FlutterSecureStorage(),
        authNotifier =
            AuthNotifier(secureStorage: const FlutterSecureStorage());

  // Add other services/notifiers as needed
}

// Provider for AppDependencies
final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});

// Step 2: Create AuthNotifier to handle login/logout and session persistence
class AuthNotifier extends StateNotifier<bool> {
  final FlutterSecureStorage _storage;

  AuthNotifier({required FlutterSecureStorage secureStorage})
      : _storage = secureStorage,
        super(false) {
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

// Step 3: Define the authProvider to expose the authentication state
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final appDependencies = ref.read(appDependenciesProvider);
  return appDependencies.authNotifier;
});

// Step 4: Main App with AppDependencies injection
void main() {
  // Create an instance of AppDependencies to inject globally
  final appDependencies = AppDependencies();

  runApp(
    ProviderScope(
      overrides: [
        // Override the global appDependenciesProvider with the instance
        appDependenciesProvider.overrideWithValue(appDependencies),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access AppDependencies and use them in your app
    final appDependencies = ref.watch(appDependenciesProvider);
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
            check: (context, location) => ref.read(authProvider),
            onCheckFailed: (context, location) =>
                Beamer.of(context).beamToNamed('/login'),
          ),
          BeamGuard(
            pathPatterns: ['/login', '/splash'],
            check: (context, location) => !ref.read(authProvider),
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

// Step 5: Refactor the authInitializationProvider to use the injected dependencies
final authInitializationProvider = FutureProvider<bool>((ref) async {
  final appDependencies = ref.read(appDependenciesProvider);
  await appDependencies.authNotifier._checkAuthStatus();
  return true;
});

// SplashScreen remains the same
class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(Duration(seconds: 2), () {
      final isLoggedIn = ref.read(authProvider);
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

// LoginPage and other pages remain the same
class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await ref
                  .read(appDependenciesProvider)
                  .authNotifier
                  .login('dummy_token');
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
