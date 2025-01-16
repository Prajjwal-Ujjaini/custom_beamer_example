import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dependencies/app_dependencies.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';

class OrderNotifier extends StateNotifier<List<OrderModel>> {
  final OrderService orderService;

  OrderNotifier({required this.orderService}) : super(orderService.orders);

  void placeOrder(OrderModel order) {
    orderService.placeOrder(order);
    state = orderService.orders;
  }

  OrderModel? getOrderById(String orderId) {
    return orderService.getOrderById(orderId);
  }

  // Fetch orders (e.g., by order ID or user ID if needed)
  List<OrderModel> getOrders() {
    return state;
  }
}

final orderProvider =
    StateNotifierProvider<OrderNotifier, List<OrderModel>>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return OrderNotifier(orderService: dependencies.orderService);
});
