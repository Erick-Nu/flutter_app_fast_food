import '../../../../core/config/supabase_client.dart';
import '../models/product_model.dart';
import '../../../../core/utils/logger.dart'; // Usamos tu logger

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      // 1. Hacemos la query a Supabase
      final data = await SupabaseConfig.client
          .from('productos') // Nombre exacto de tu tabla en Supabase
          .select(); 

      // 2. Convertimos la lista de JSONs a lista de ProductModels
      final List<dynamic> responseList = data as List<dynamic>;
      return responseList.map((json) => ProductModel.fromJson(json)).toList();
      
    } catch (e) {
      logger.e('Error obteniendo productos de Supabase', error: e);
      throw Exception('Error de conexión con base de datos');
    }
  }
}