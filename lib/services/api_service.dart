import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchServices() async {
    final response = await http.get(Uri.parse(
        'https://66c58be9134eb8f43494a35b.mockapi.io/videos/services'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch services');
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());
