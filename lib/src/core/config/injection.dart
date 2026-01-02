import 'package:get_it/get_it.dart';
import '../../features/product/data/datasources/product_remote_data_source.dart';
import '../../features/product/data/repositories/product_repository_impl.dart';
import '../../features/product/domain/repositories/product_repository.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  sl.registerLazySingleton<ProductRemoteDataSource>(() => ProductRemoteDataSourceImpl());
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(remoteDataSource: sl()));
}