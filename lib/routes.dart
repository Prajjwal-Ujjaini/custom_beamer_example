import 'package:beamer/beamer.dart';

import 'beam_locations/beam_locations.dart';

final routerDelegate = BeamerDelegate(
    initialPath: '/home',
    //   locationBuilder: RoutesLocationBuilder(
    //   routes: {
    //     '/': (context, state) => const HomeScreen(),
    //     '/profile': (context, state) => const ProfileScreen(),
    //     '/settings': (context, state) => const SettingsScreen(),
    //   },
    // ),

    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        ProfileLocation(),
        TaskLocation(),
        ServicesLocation(),
        SettingsLocation(),
        BooksLocation(),
        ArticlesLocation(),
      ],
    ).call

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
