import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dependencies/app_dependencies.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../services/cart_service.dart';
import 'order_provider.dart';

class CartNotifier extends StateNotifier<List<CartModel>> {
  final CartService cartService;

  CartNotifier({required this.cartService}) : super(cartService.cartItems);

  void addToCart(CartModel item) {
    cartService.addToCart(item);
    state = cartService.cartItems;
  }

  void updateQuantity(String productId, int quantity) {
    cartService.updateQuantity(productId, quantity);
    state = cartService.cartItems;
  }

  void removeFromCart(String productId) {
    cartService.removeFromCart(productId);
    state = cartService.cartItems;
  }

  void clearCart() {
    cartService.clearCart();
    state = cartService.cartItems;
  }

  double get totalPrice => cartService.totalPrice;

  void placeOrder() {
    if (cartService.cartItems.isEmpty) {
      throw Exception('Cart is empty. Cannot place an order.');
    }

    final order = OrderModel(
      orderId: DateTime.now().toIso8601String(),
      orderDate: DateTime.now(),
      products: cartService.cartItems
          .map((item) => {
                'productId': item.productId,
                'name': item.name,
                'quantity': item.quantity,
                'price': item.price,
              })
          .toList(),
      totalPrice: cartService.totalPrice,
    );

    // Obtain the OrderNotifier and place the order
    cartService.clearCart();
    state = cartService.cartItems;
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartModel>>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return CartNotifier(cartService: dependencies.cartService);
});
