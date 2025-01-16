import 'package:beamer_example/models/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dependencies/app_dependencies.dart';
import '../services/product_service.dart';

final productProvider =
    StateNotifierProvider<ProductNotifier, List<ProductModel>>((ref) {
  final dependencies = ref.read(appDependenciesProvider);
  return dependencies.productNotifier;
});

class ProductNotifier extends StateNotifier<List<ProductModel>> {
  final ProductService productService;

  ProductNotifier({required this.productService}) : super([]);

  Future<void> loadProducts() async {
    final products = await productService.fetchProducts();
    state = products;
  }

  Future<void> addProduct(ProductModel product) async {
    final newProduct = await productService.createProduct(product);
    state = [...state, newProduct];
  }

  Future<void> editProduct(ProductModel updatedProduct) async {
    final product = await productService.updateProduct(updatedProduct);
    state = state.map((p) => p.id == product.id ? product : p).toList();
  }

  Future<void> removeProduct(String productId) async {
    await productService.deleteProduct(productId);
    state = state.where((p) => p.id != productId).toList();
  }
}
