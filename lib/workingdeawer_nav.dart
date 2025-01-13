// import 'package:flutter/material.dart';
// import 'package:beamer/beamer.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerDelegate: BeamerDelegate(
//         initialPath: '/home',
//         locationBuilder: RoutesLocationBuilder(
//           routes: {
//             '/home': (context, state, data) =>
//                 MainLayout(content: const HomeContent()),
//             '/profile': (context, state, data) =>
//                 MainLayout(content: const ProfileContent()),
//             '/settings': (context, state, data) =>
//                 MainLayout(content: const SettingsContent()),
//           },
//         ),
//       ),
//       routeInformationParser: BeamerParser(),
//     );
//   }
// }

// // Drawer Items
// final List<Map<String, String>> _drawerItems = [
//   {'label': 'Home', 'route': '/home'},
//   {'label': 'Profile', 'route': '/profile'},
//   {'label': 'Settings', 'route': '/settings'},
// ];

// // Bottom Navigation Items
// final List<Map<String, dynamic>> _bottomNavItems = [
//   {'label': 'Home', 'icon': Icons.home, 'route': '/home'},
//   {'label': 'Profile', 'icon': Icons.person, 'route': '/profile'},
//   {'label': 'Settings', 'icon': Icons.settings, 'route': '/settings'},
// ];

// // Shared Layout
// class MainLayout extends StatefulWidget {
//   final Widget content;

//   const MainLayout({Key? key, required this.content}) : super(key: key);

//   @override
//   _MainLayoutState createState() => _MainLayoutState();
// }

// class _MainLayoutState extends State<MainLayout> {
//   int _selectedIndex = 0;

//   void _onBottomNavTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     final route = _bottomNavItems[index]['route'] as String;
//     Beamer.of(context).beamToNamed(route);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Persistent Layout Example')),
//       drawer: Drawer(
//         child: ListView.builder(
//           itemCount: _drawerItems.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text(_drawerItems[index]['label']!),
//               onTap: () {
//                 final route = _drawerItems[index]['route']!;
//                 Navigator.of(context).pop(); // Close the drawer
//                 Beamer.of(context).beamToNamed(route);
//               },
//             );
//           },
//         ),
//       ),
//       body: widget.content, // Dynamic Content
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onBottomNavTap,
//         items: _bottomNavItems.map((item) {
//           return BottomNavigationBarItem(
//             icon: Icon(item['icon'] as IconData),
//             label: item['label'] as String,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// // Individual Page Contents
// class HomeContent extends StatelessWidget {
//   const HomeContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Home Page Content'),
//     );
//   }
// }

// class ProfileContent extends StatelessWidget {
//   const ProfileContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Profile Page Content'),
//     );
//   }
// }

// class SettingsContent extends StatelessWidget {
//   const SettingsContent({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Settings Page Content'),
//     );
//   }
// }
