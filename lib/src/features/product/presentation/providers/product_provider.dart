import 'package:flutter/material.dart';
import '../../../../core/config/injection.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../../../core/utils/logger.dart';

class ProductProvider extends ChangeNotifier {
  // Estado
  List<ProductEntity> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters para que la UI lea el estado
  List<ProductEntity> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Acción: Cargar productos
  Future<void> loadPopularProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Avisa a la pantalla: "Estoy cargando..."

    try {
      // Usamos el repositorio que registramos en GetIt
      final repository = sl<ProductRepository>();
      
      _products = await repository.getPopularProducts();
      logger.i('Productos cargados en Provider: ${_products.length}');
      
    } catch (e) {
      _errorMessage = 'No se pudieron cargar las pizzas';
      logger.e('Error en Provider', error: e);
    } finally {
      _isLoading = false;
      notifyListeners(); // Avisa a la pantalla: "Terminé (con éxito o error)"
    }
  }
}