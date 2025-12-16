import 'package:flutter/material.dart';
import '../../domain/entities/cart_item.dart';
import '../../../product/domain/entities/product_entity.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Calcula el total a pagar sumando todos los subtotales
  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  // Cantidad total de productos (para el numerito rojo en el icono del carrito)
  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Agregar producto
  void addToCart(ProductEntity product) {
    // 1. Verificamos si ya existe en el carrito
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // 2. Si ya existe, solo aumentamos la cantidad
      _items[index].quantity++;
    } else {
      // 3. Si no existe, lo agregamos nuevo
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  // Disminuir cantidad o eliminar
  void removeOneItem(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index < 0) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  // Eliminar el producto completo (ej: deslizar para borrar)
  void removeProductCompletely(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Limpiar carrito (al terminar la compra)
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}