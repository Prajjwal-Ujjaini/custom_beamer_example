import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';
import '../models/drawer_item_model.dart';
import 'auth_provider.dart';
import 'http_client_provider.dart';

final drawerItemsProvider = FutureProvider<List<DrawerItemModel>>((ref) async {
  final client = ref.read(httpClientProvider);
  // Fetch dynamic items
  final response = await client.get(
      Uri.parse('https://66c58be9134eb8f43494a35b.mockapi.io/videos/services'));
  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    final dynamicItems = data.map((item) {
      return DrawerItemModel(
        title: item['title'],
        icon: Icons.home, // Replace with actual icon if your API provides it
        route: '/books', //item['route'],
      );
    }).toList();

    // Combine static and dynamic items
    return [staticItems.first, ...dynamicItems, staticItems.last];
  } else {
    throw Exception('Failed to load drawer items');
  }
});

// final authDrawerItemsProvider =
//     FutureProvider<List<DrawerItemModel>>((ref) async {
//   final authState = ref.watch(authProvider);

//   // Static items (always visible)
//   final List<DrawerItemModel> staticItems = [
//     DrawerItemModel(title: 'Home', icon: Icons.home, route: '/home'),
//   ];

//   // Dynamic items
//   final client = ref.read(httpClientProvider);
//   final response = await client.get(
//       Uri.parse('https://66c58be9134eb8f43494a35b.mockapi.io/videos/services'));
//   List<DrawerItemModel> dynamicItems = [];

//   if (response.statusCode == 200) {
//     final List data = jsonDecode(response.body);
//     dynamicItems = data.map((item) {
//       return DrawerItemModel(
//           title: item['title'],
//           icon: Icons.home, // Replace with actual icon
//           route: '/task' //item['route'],
//           );
//     }).toList();
//   }

//   print("authState.isAuthenticated== ${authState.isAuthenticated}");
//   // Auth-based items
//   final List<DrawerItemModel> authItems = authState.isAuthenticated
//       ? [DrawerItemModel(title: 'Logout', icon: Icons.logout, route: '/logout')]
//       : [DrawerItemModel(title: 'Login', icon: Icons.login, route: '/login')];

//   return [...staticItems, ...dynamicItems, ...authItems];
// });

// final drawerManagerProvider = ChangeNotifierProvider<DrawerManager>((ref) {
//   final authNotifier = ref.read(authProvider.notifier);
//   return DrawerManager(authNotifier: authNotifier);
// });

// final drawerProvider =
//     StateNotifierProvider<DrawerNotifier, DrawerState>((ref) {
//   final authNotifier = ref.read(authProvider.notifier);
//   return DrawerNotifier(authNotifier);
// });

// final authDrawerItemsProvider = Provider<List<DrawerItemModel>>((ref) {
//   final authState = ref.watch(authProvider);

//   // Static items (always visible)
//   final List<DrawerItemModel> staticItems = [
//     DrawerItemModel(title: 'Home', icon: Icons.home, route: '/home'),
//   ];

//   // Auth-based items
//   final List<DrawerItemModel> authItems = authState.isAuthenticated
//       ? [DrawerItemModel(title: 'Logout', icon: Icons.logout, route: '/logout')]
//       : [DrawerItemModel(title: 'Login', icon: Icons.login, route: '/login')];

//   // Combine static and auth-based items
//   return [...staticItems, ...authItems];
// });

// final dynamicDrawerItemsProvider =
//     FutureProvider<List<DrawerItemModel>>((ref) async {
//   final client = ref.read(httpClientProvider);
//   final response = await client.get(
//       Uri.parse('https://66c58be9134eb8f43494a35b.mockapi.io/videos/services'));

//   if (response.statusCode == 200) {
//     final List data = jsonDecode(response.body);
//     return data.map<DrawerItemModel>((item) {
//       return DrawerItemModel(
//         title: item['title'],
//         icon: Icons.home, // Replace with actual icon
//         route: '/task', // Replace with item['route'] if available
//       );
//     }).toList();
//   }
//   return [];
// });

// final combinedDrawerItemsProvider = Provider<List<DrawerItemModel>>((ref) {
//   final staticAndAuthItems = ref.watch(authDrawerItemsProvider);
//   final dynamicItems = ref.watch(dynamicDrawerItemsProvider).maybeWhen(
//         data: (items) => items,
//         orElse: () => [],
//       );

//   return [...staticAndAuthItems, ...dynamicItems];
// });

// final drawerNotifierProvider =
//     StateNotifierProvider<DrawerNotifier, DrawerState>((ref) {
//   final apiService = ref.read(apiServiceProvider);
//   return DrawerNotifier(ref: ref, apiService: apiService);
// });

// final drawerNotifierProvider =
//     StateNotifierProvider<DrawerNotifier, DrawerState>((ref) {
//   final apiService = ref.read(apiServiceProvider);
//   return DrawerNotifier(apiService: apiService, ref: ref);
// });

// final authDrawerItemsProvider =
//     FutureProvider<List<DrawerItemModel>>((ref) async {
//   final authState = ref.watch(authProvider); // Listen to auth state changes

//   final List<DrawerItemModel> staticItems = [
//     DrawerItemModel(title: 'Home', icon: Icons.home, route: '/home'),
//   ];

//   // Fetch dynamic items
//   final client = ref.read(httpClientProvider);
//   final response = await client.get(
//       Uri.parse('https://66c58be9134eb8f43494a35b.mockapi.io/videos/services'));
//   List<DrawerItemModel> dynamicItems = [];
//   if (response.statusCode == 200) {
//     final List data = jsonDecode(response.body);
//     dynamicItems = data.map((item) {
//       return DrawerItemModel(
//         title: item['title'],
//         icon: Icons.task,
//         route: '/task',
//       );
//     }).toList();
//   }

//   final List<DrawerItemModel> authItems = authState.isAuthenticated
//       ? [DrawerItemModel(title: 'Logout', icon: Icons.logout, route: '/logout')]
//       : [DrawerItemModel(title: 'Login', icon: Icons.login, route: '/login')];

//   return [...staticItems, ...dynamicItems, ...authItems];
// });

final authDrawerItemsProvider = Provider<List<DrawerItemModel>>((ref) {
  final authState = ref.watch(authProvider);

  // Static items (always visible)
  final List<DrawerItemModel> staticItems = [
    DrawerItemModel(title: 'Home', icon: Icons.home, route: '/home'),
  ];

  // Auth-based items
  final List<DrawerItemModel> authItems = authState.isAuthenticated
      ? [DrawerItemModel(title: 'Logout', icon: Icons.logout, route: '/logout')]
      : [DrawerItemModel(title: 'Login', icon: Icons.login, route: '/login')];

  return [...staticItems, ...authItems];
});
