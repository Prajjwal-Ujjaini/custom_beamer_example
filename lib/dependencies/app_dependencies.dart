import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/auth_provider.dart';
import '../provider/cart_provider.dart';
import '../provider/order_provider.dart';
import '../provider/product_provider.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import '../services/product_service.dart';

class AppDependencies {
  final AuthService authService;
  final AuthNotifier authNotifier;
  final ProductService productService;
  final ProductNotifier productNotifier;
  final CartService cartService;
  final CartNotifier cartNotifier;
  final OrderService orderService;
  final OrderNotifier orderNotifier;

  AppDependencies()
      : authService = AuthService(),
        authNotifier = AuthNotifier(authService: AuthService()),
        productService = ProductService(),
        productNotifier = ProductNotifier(productService: ProductService()),
        cartService = CartService(),
        cartNotifier = CartNotifier(cartService: CartService()),
        orderService = OrderService(),
        orderNotifier = OrderNotifier(orderService: OrderService());
}

final appDependenciesProvider = Provider<AppDependencies>((ref) {
  throw UnimplementedError(
      'AppDependencies must be provided via ProviderScope.overrideWithValue.');
});


// final appDependenciesProvider = Provider<AppDependencies>((ref) {
//   return AppDependencies();
// });