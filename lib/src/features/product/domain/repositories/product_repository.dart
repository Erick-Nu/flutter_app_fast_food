import '../entities/product_entity.dart';

// Es una clase abstracta porque solo define el "QUÉ", no el "CÓMO".
abstract class ProductRepository {
  Future<List<ProductEntity>> getPopularProducts();
}