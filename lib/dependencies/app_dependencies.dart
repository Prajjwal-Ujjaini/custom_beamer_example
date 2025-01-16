import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';

import '../provider/product_provider.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';

class AppDependencies {
  final AuthService authService;
  final AuthNotifier authNotifier;
  final ProductService productService;
  final ProductNotifier productNotifier;

  AppDependencies()
      : authService = AuthService(),
        authNotifier = AuthNotifier(authService: AuthService()),
        productService = ProductService(),
        productNotifier = ProductNotifier(productService: ProductService());
}

// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});
