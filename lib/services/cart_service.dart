import '../models/cart_model.dart';

class CartService {
  final List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(CartModel item) {
    final existingIndex = _cartItems
        .indexWhere((cartItem) => cartItem.productId == item.productId);
    if (existingIndex != -1) {
      _cartItems[existingIndex] = CartModel(
        productId: _cartItems[existingIndex].productId,
        name: _cartItems[existingIndex].name,
        quantity: _cartItems[existingIndex].quantity + item.quantity,
        price: _cartItems[existingIndex].price,
      );
    } else {
      _cartItems.add(item);
    }
  }

  void updateQuantity(String productId, int quantity) {
    final index =
        _cartItems.indexWhere((cartItem) => cartItem.productId == productId);
    if (index != -1) {
      _cartItems[index] = CartModel(
        productId: _cartItems[index].productId,
        name: _cartItems[index].name,
        quantity: quantity,
        price: _cartItems[index].price,
      );
    }
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((cartItem) => cartItem.productId == productId);
  }

  void clearCart() {
    _cartItems.clear();
  }

  double get totalPrice =>
      _cartItems.fold(0, (total, item) => total + item.total);
}
