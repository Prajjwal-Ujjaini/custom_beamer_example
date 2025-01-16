import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cart_model.dart';

class CartNotifier extends StateNotifier<List<CartModel>> {
  CartNotifier() : super([]);

  void addToCart(CartModel item) {
    final existingIndex =
        state.indexWhere((cartItem) => cartItem.productId == item.productId);
    if (existingIndex != -1) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex)
            CartModel(
              productId: state[i].productId,
              name: state[i].name,
              quantity: state[i].quantity + item.quantity,
              price: state[i].price,
            )
          else
            state[i],
      ];
    } else {
      state = [...state, item];
    }
  }

  void updateQuantity(String productId, int quantity) {
    state = [
      for (final item in state)
        if (item.productId == productId)
          CartModel(
            productId: item.productId,
            name: item.name,
            quantity: quantity,
            price: item.price,
          )
        else
          item,
    ];
  }

  void removeFromCart(String productId) {
    state = state.where((item) => item.productId != productId).toList();
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice => state.fold(0, (total, item) => total + item.total);
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<CartModel>>((ref) {
  return CartNotifier();
});
