import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';
import 'package:riverpod_files/providers/services/products_service_provider.dart';

part 'products_provider.g.dart';

// @riverpod
// List<Product> products(ref) {
//   return allProducts;
// }

// @riverpod
// List<Product> reducedProducts(ref) {
//   return allProducts.where((p) => p.price < 50).toList();
// }

@riverpod
class Products extends _$Products {
  @override
  Future<List<Product>> build() async {
    final repository = ref.read(productsServiceProvider);
    return repository.fetchProducts();
  }

  Future<void> removeProduct(String productId) async {
    final repository = ref.read(productsServiceProvider);

    final oldState = state.value;

    try {
      await repository.removeProduct(productId);

      final newList = state.value?.where((p) => p.id != productId).toList();

      state = AsyncValue.data(newList ?? []);
    } catch (e) {
      print('Erro ao remover produto: $e');
      state = AsyncValue.data(oldState ?? []);
    }
  }
}
