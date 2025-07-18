import 'package:riverpod_files/models/product.dart';

const List<Product> allProducts = [
  Product(
    id: '1',
    title: 'Groovy Shorts',
    price: 12,
    image: 'assets/products/shorts.png',
  ),
  Product(
    id: '2',
    title: 'Karati Kit',
    price: 34,
    image: 'assets/products/karati.png',
  ),
  Product(
    id: '3',
    title: 'Denim Jeans',
    price: 54,
    image: 'assets/products/jeans.png',
  ),
  Product(
    id: '4',
    title: 'Red Backpack',
    price: 14,
    image: 'assets/products/backpack.png',
  ),
  Product(
    id: '5',
    title: 'Drum & Sticks',
    price: 29,
    image: 'assets/products/drum.png',
  ),
  Product(
    id: '6',
    title: 'Blue Suitcase',
    price: 44,
    image: 'assets/products/suitcase.png',
  ),
  Product(
    id: '7',
    title: 'Roller Skates',
    price: 52,
    image: 'assets/products/skates.png',
  ),
  Product(
    id: '8',
    title: 'Electric Guitar',
    price: 79,
    image: 'assets/products/guitar.png',
  ),
];

class ProductsService {
  Future<List<Product>> fetchProducts() async {
    // Simula uma espera de 2 segundos, como uma chamada de API
    await Future.delayed(const Duration(seconds: 2));

    // Simula uma chance de erro na rede
    // Para testar o estado de erro, descomente a linha abaixo:
    // throw Exception('Falha ao conectar com o servidor.');

    // Retorna a lista de produtos se tudo der certo
    return allProducts;
  }

  Future<void> removeProduct(String productId) async {
    // Simula uma espera de 1 segundo para a chamada de rede
    await Future.delayed(const Duration(seconds: 1));
    print('Produto $productId removido no backend.');

    // Para testar um erro, você pode descomentar a linha abaixo.
    // throw Exception('Falha de conexão: Não foi possível remover o produto.');

    return; // Sucesso
  }
}
