import 'package:beamer_example/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart_model.dart';
import '../provider/cart_provider.dart';
import '../provider/product_provider.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final productNotifier = ref.read(productProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: products.isEmpty
          ? const Center(child: Text('No products available'))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          final cartNotifier = ref.read(cartProvider.notifier);
                          cartNotifier.addToCart(CartModel(
                            productId: product.id,
                            name: product.name,
                            quantity: 1,
                            price: product.price,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('${product.name} added to cart')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showProductForm(context, productNotifier,
                              product: product);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          productNotifier.removeProduct(product.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProductForm(context, productNotifier);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showProductForm(BuildContext context, ProductNotifier notifier,
      {ProductModel? product}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });

    final nameController = TextEditingController(text: product?.name ?? '');
    final descriptionController =
        TextEditingController(text: product?.description ?? '');
    final priceController =
        TextEditingController(text: product?.price.toString() ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final name = nameController.text;
                      final description = descriptionController.text;
                      final price = double.tryParse(priceController.text) ?? 0;

                      if (name.isNotEmpty &&
                          description.isNotEmpty &&
                          price > 0) {
                        final newProduct = ProductModel(
                          id: product?.id ?? DateTime.now().toString(),
                          name: name,
                          description: description,
                          price: price,
                        );

                        print('product : = ${product}');
                        if (product == null) {
                          notifier.addProduct(newProduct);
                        } else {
                          notifier.editProduct(newProduct);
                        }
                      } else {
                        print('validate product failed');
                      }

                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
