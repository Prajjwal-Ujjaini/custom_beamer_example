import 'package:beamer/beamer.dart';
import 'beam_locations/beam_locations.dart';

import 'provider/auth_provider.dart';

BeamerDelegate createRouterDelegate(AuthNotifier authNotifier) {
  return BeamerDelegate(
    initialPath: '/home',

    guards: [
      BeamGuard(
        pathPatterns: ['/logout'],
        check: (context, location) {
          authNotifier.logout();
          return false; // Prevents navigation to the actual `/logout` page.
        },
        onCheckFailed: (context, location) {
          Beamer.of(context).beamToNamed('/home'); // Redirect to login.
        },
      ),
    ],

    //   locationBuilder: RoutesLocationBuilder(
    //   routes: {
    //     '/': (context, state) => const HomeScreen(),
    //     '/profile': (context, state) => const ProfileScreen(),
    //     '/settings': (context, state) => const SettingsScreen(),
    //   },
    // ),

//auth
    //   locationBuilder: RoutesLocationBuilder(
    //   routes: {
    // '/': (context, state) => const HomeScreen(),
    // '/login': (context, state) => const LoginScreen(),
    // '/logout': (context, state) {
    //   final authNotifier = context.read(authProvider.notifier);
    //   authNotifier.logout();
    //   return const LoginScreen();
    // },
    //   },
    // ),
// auth
    //   locationBuilder: (routeInformation, _) {
    //   final container = ProviderScope.containerOf(globalContext); // Get global context
    //   final authNotifier = container.read(authProvider.notifier);

    //   if (routeInformation.location?.startsWith('/login') == true ||
    //       routeInformation.location?.startsWith('/logout') == true) {
    //     return AuthLocation(routeInformation, authNotifier);
    //   }
    //   return HomeLocation(routeInformation);
    // },

    locationBuilder: (routeInformation, _) {
      // Create a list of locations dynamically
      final beamLocations = [
        AuthLocation(authNotifier: authNotifier),
        HomeLocation(),
        ProfileLocation(),
        TaskLocation(),
        ServicesLocation(),
        SettingsLocation(),
        BooksLocation(),
        ArticlesLocation(),
      ];

      // Use BeamerLocationBuilder for matching
      return BeamerLocationBuilder(beamLocations: beamLocations).call(
        routeInformation,
        _,
      );
    },

    // locationBuilder: BeamerLocationBuilder(
    //   beamLocations: [
    //     AuthLocation(),
    //     HomeLocation(),
    //     ProfileLocation(),
    //     TaskLocation(),
    //     ServicesLocation(),
    //     SettingsLocation(),
    //     BooksLocation(),
    //     ArticlesLocation(),
    //   ],
    // ).call

    // locationBuilder: (routeInformation, _) {
    //   if (routeInformation.location!.startsWith('/services')) {
    //     return ServicesLocation();
    //   }
    //   if (routeInformation.location!.startsWith('/task')) {
    //     return TaskLocation();
    //   }
    //   if (routeInformation.location!.startsWith('/profile')) {
    //     return ProfileLocation();
    //   }
    //   if (routeInformation.location!.startsWith('/settings')) {
    //     return SettingsLocation();
    //   }
    //   return HomeLocation();
    // },
  );
}
