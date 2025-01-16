import '../models/order_model.dart';

class OrderService {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => List.unmodifiable(_orders);

  void placeOrder(OrderModel order) {
    _orders.add(order);
  }

  OrderModel? getOrderById(String orderId) {
    return _orders.firstWhere(
      (order) => order.orderId == orderId,
      // orElse: () => null, // Explicitly returning null
    );
  }
}
