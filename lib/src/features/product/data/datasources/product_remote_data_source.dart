import '../../../../core/config/supabase_client.dart';
import '../models/product_model.dart';
import '../../../../core/utils/logger.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final data = await SupabaseConfig.client
          .from('productos')
          .select(); 

      final List<dynamic> responseList = data as List<dynamic>;
      return responseList.map((json) => ProductModel.fromJson(json)).toList();
      
    } catch (e) {
      logger.e('Error obteniendo productos de Supabase', error: e);
      throw Exception('Error de conexión con base de datos');
    }
  }
}