import '../models/product_model.dart';

// class ProductService {
//   Future<List<ProductModel>> fetchProducts() async {
//     // Mock API call or replace with actual API logic
//     await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
//     return [
//       ProductModel(
//           id: '1', name: 'Product A', description: 'Description A', price: 100),
//       ProductModel(
//           id: '2', name: 'Product B', description: 'Description B', price: 200),
//     ];
//   }
// }

class ProductService {
  final List<ProductModel> _products =
      []; // Temporary in-memory store for demonstration

  Future<List<ProductModel>> fetchProducts() async {
    // Simulate an API call
    await Future.delayed(const Duration(seconds: 1));
    return _products;
  }

  Future<ProductModel> createProduct(ProductModel product) async {
    // Simulate creating a product
    await Future.delayed(const Duration(milliseconds: 500));
    _products.add(product);
    return product;
  }

  Future<ProductModel> updateProduct(ProductModel updatedProduct) async {
    // Simulate updating a product
    await Future.delayed(const Duration(milliseconds: 500));
    final index =
        _products.indexWhere((product) => product.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      return updatedProduct;
    }
    throw Exception('Product not found');
  }

  Future<void> deleteProduct(String productId) async {
    // Simulate deleting a product
    await Future.delayed(const Duration(milliseconds: 500));
    _products.removeWhere((product) => product.id == productId);
  }
}
