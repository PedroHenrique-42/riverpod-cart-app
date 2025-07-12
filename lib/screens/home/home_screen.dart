import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer(builder: (context, ref, child) {
          final productsResult = ref.watch(productsProvider);
          final cartProducts = ref.watch(cartNotifierProvider);

          return productsResult.when(
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
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final isInCart = cartProducts.contains(product);

                  return Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.blueGrey.withOpacity(0.05),
                    child: Column(
                      children: [
                        Image.asset(product.image, width: 60, height: 60),
                        Text(product.title),
                        Text('\$${product.price}'),
                        if (isInCart)
                          TextButton(
                            onPressed: () => ref
                                .read(cartNotifierProvider.notifier)
                                .removeProduct(product),
                            child: const Text('Remove'),
                          )
                        else
                          TextButton(
                            onPressed: () => ref
                                .read(cartNotifierProvider.notifier)
                                .addProduct(product),
                            child: const Text('Add to cart'),
                          )
                      ],
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Text('Ocorreu um erro: $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }),
      ),
    );
  }
}
