import 'package:flutter/material.dart';
import '../../domain/entities/cart_item.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../data/order_repository.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final OrderRepository _orderRepository = OrderRepository();

  List<CartItem> get items => _items;

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  int get itemCount {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  void addToCart(ProductEntity product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

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

  void removeProductCompletely(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  Future<bool> submitOrder(String userId) async {
    if (_items.isEmpty) return false;

    _isProcessing = true;
    notifyListeners(); 

    final double totalConEnvio = totalAmount + 2.50; 

    final success = await _orderRepository.createOrder(
      userId: userId,
      total: totalConEnvio,
      items: _items,
    );

    if (success) {
      clearCart();
    }

    _isProcessing = false;
    notifyListeners();
    
    return success;
  }
}