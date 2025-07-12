import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/services/products/products_service.dart';

part 'products_service_provider.g.dart';

@riverpod
ProductsService productsService(Ref ref) {
  return ProductsService();
}
