import 'package:flutter/material.dart';
import '../../data/order_repository.dart';
import '../../data/models/order_model.dart';
import '../../data/models/order_detail_model.dart';

class OrderProvider extends ChangeNotifier {
  final OrderRepository _repository = OrderRepository();
  
  List<OrderModel> _orders = [];
  bool _isLoading = false;

  List<OrderDetailModel> _currentDetails = [];
  bool _isLoadingDetails = false;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;
  
  List<OrderDetailModel> get currentDetails => _currentDetails;
  bool get isLoadingDetails => _isLoadingDetails;

  Future<void> fetchOrders(String userId) async {
    _isLoading = true;
    notifyListeners(); // Avisamos para mostrar spinner

    _orders = await _repository.getOrders(userId);

    _isLoading = false;
    notifyListeners(); // Avisamos para mostrar la lista
  }

  Future<void> fetchOrderDetails(String orderId) async {
    _isLoadingDetails = true;
    _currentDetails = []; // Limpiamos lo anterior para no mostrar datos viejos
    notifyListeners();

    _currentDetails = await _repository.getOrderDetails(orderId);

    _isLoadingDetails = false;
    notifyListeners();
  }
}