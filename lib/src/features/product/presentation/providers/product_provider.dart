import 'package:flutter/material.dart';
import '../../../../core/config/injection.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../../core/utils/logger.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductEntity> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProductEntity> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPopularProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final repository = sl<ProductRepository>();
      
      _products = await repository.getPopularProducts();
      logger.i('Productos cargados en Provider: ${_products.length}');
      
    } catch (e) {
      _errorMessage = 'No se pudieron cargar las pizzas';
      logger.e('Error en Provider', error: e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}