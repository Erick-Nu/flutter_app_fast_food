import '../../../product/domain/entities/product_entity.dart';

class CartItem {
  final ProductEntity product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get subtotal => product.price * quantity;
}