class CartModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  CartModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}
