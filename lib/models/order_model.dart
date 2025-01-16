class OrderModel {
  final String orderId;
  final DateTime orderDate;
  final List<Map<String, dynamic>>
      products; // Each item contains productId, name, quantity, price.
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.orderDate,
    required this.products,
    required this.totalPrice,
  });
}
