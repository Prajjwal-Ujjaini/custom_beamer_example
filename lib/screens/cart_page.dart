import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../provider/cart_provider.dart';
import '../provider/order_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final orderNotifier = ref.read(orderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                      'Price: \$${item.price}, Quantity: ${item.quantity}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle),
                        onPressed: () {
                          if (item.quantity > 1) {
                            cartNotifier.updateQuantity(
                                item.productId, item.quantity - 1);
                          } else {
                            cartNotifier.removeFromCart(item.productId);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          cartNotifier.updateQuantity(
                              item.productId, item.quantity + 1);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          cartNotifier.removeFromCart(item.productId);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Total: \$${cartNotifier.totalPrice.toStringAsFixed(2)}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      cartNotifier.clearCart();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Order placed successfully!')),
                      );
                    },
                    child: const Text('Checkout'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      try {
                        cartNotifier.placeOrder();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order placed!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                    child: const Text('Place Order'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     try {
                  //       // Prepare the order details (replace with your actual data)
                  //       final order = OrderModel(
                  //         orderId: DateTime.now()
                  //             .toString(), // Generating unique orderId
                  //         userId:
                  //             'user123', // Example user ID, replace as needed
                  //         productIds: [
                  //           'product1',
                  //           'product2'
                  //         ], // Example product IDs, replace with actual data
                  //         totalPrice: cartNotifier
                  //             .totalPrice, // Use the total price from the cart
                  //         orderDate: DateTime.now(),
                  //       );

                  //       // Place the order
                  //       cartNotifier.placeOrder(order);

                  //       // Show confirmation message
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('Order placed!')),
                  //       );
                  //     } catch (e) {
                  //       // Handle error (e.g., show error message if order placement fails)
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text(e.toString())),
                  //       );
                  //     }
                  //   },
                  //   child: const Text('Place Order'),
                  // )
                ],
              ),
            )
          : null,
    );
  }
}
