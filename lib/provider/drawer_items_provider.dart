import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';
import '../models/drawer_item_model.dart';
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
