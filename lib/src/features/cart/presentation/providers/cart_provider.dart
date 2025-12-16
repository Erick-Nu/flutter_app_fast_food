import 'package:flutter/material.dart';
import '../../domain/entities/cart_item.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../data/order_repository.dart'; // <--- 1. IMPORTAR EL REPO

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  final OrderRepository _orderRepository = OrderRepository(); // <--- 2. INSTANCIAR REPO

  List<CartItem> get items => _items;

  // ESTADO DE CARGA (Para bloquear el botón mientras se envía)
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

  // --- 3. NUEVO MÉTODO: ENVIAR PEDIDO ---
  Future<bool> submitOrder(String userId) async {
    if (_items.isEmpty) return false;

    // Activamos modo carga (spinner)
    _isProcessing = true;
    notifyListeners(); 

    // Calculamos total final (Precio productos + Envío)
    // Asegúrate que este 2.50 coincida con lo que muestras en la pantalla CartScreen
    final double totalConEnvio = totalAmount + 2.50; 

    // Llamamos al repositorio
    final success = await _orderRepository.createOrder(
      userId: userId,
      total: totalConEnvio,
      items: _items,
    );

    if (success) {
      clearCart(); // Si se guardó, vaciamos el carrito local
    }

    // Desactivamos modo carga
    _isProcessing = false;
    notifyListeners();
    
    return success;
  }
}