import 'package:get_it/get_it.dart';
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> initInjection() async {
  // 1. Feature: Product
  // Registramos el DataSource (la pieza que habla con Supabase)
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );

  // Registramos el Repositorio (la pieza que habla con el Dominio)
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()), // ¡GetIt inyecta el datasource automáticamente aquí!
  );
}