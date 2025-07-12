import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/product.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Container productItem(Product product, WidgetRef ref, bool isInCart) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blueGrey.withOpacity(0.05),
      child: Column(
        children: [
          Image.asset(product.image, width: 60, height: 60),
          Text(product.title),
          Text('\$${product.price}'),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () =>
                ref.read(productsProvider.notifier).removeProduct(product.id),
          ),
          if (isInCart)
            TextButton(
              onPressed: () => ref
                  .read(cartNotifierProvider.notifier)
                  .removeProduct(product),
              child: const Text('Remove'),
            )
          else
            TextButton(
              onPressed: () =>
                  ref.read(cartNotifierProvider.notifier).addProduct(product),
              child: const Text('Add to cart'),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncProducts = ref.watch(productsProvider);
    final cartProducts = ref.watch(cartNotifierProvider);
    final isRefreshing = asyncProducts.isRefreshing;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed:
                isRefreshing ? null : () => ref.refresh(productsProvider),
          ),
          const CartIcon()
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => await ref.refresh(productsProvider),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: asyncProducts.when(
            skipLoadingOnRefresh: false,
            data: (products) {
              if (products.isEmpty) {
                return const Center(child: Text('Nenhum produto encontrado.'));
              }

              return GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.74,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isInCart = cartProducts.contains(product);

                  return productItem(product, ref, isInCart);
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Text('Ocorreu um erro: $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
