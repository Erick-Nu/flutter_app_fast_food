import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ProductEntity>> getPopularProducts() async {
    // Aquí podrías agregar lógica extra, ej: verificar si hay internet.
    // Por ahora, simplemente llamamos al datasource.
    final productModels = await remoteDataSource.getProducts();
    
    // Devolvemos los modelos (que son hijos de Entity), así que cumple el contrato.
    return productModels;
  }
}