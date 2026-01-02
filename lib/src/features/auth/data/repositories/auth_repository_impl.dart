import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  Future<UserEntity> _buildUserEntity(String userId, String email) async {
    final profileData = await remoteDataSource.getUserProfile(userId);
    
    return UserEntity(
      id: userId,
      email: email,
      name: profileData['nombre'] ?? 'Usuario',
      points: profileData['puntos'] ?? 0,
      levelName: profileData['nombre_nivel'] ?? 'Novato',
    );
  }

  @override
  Future<UserEntity> signIn(String email, String password) async {
    final user = await remoteDataSource.signIn(email, password);
    return _buildUserEntity(user.id, user.email!);
  }

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    final user = await remoteDataSource.signUp(email, password, name);
    await Future.delayed(const Duration(seconds: 1));
    return _buildUserEntity(user.id, user.email!);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = remoteDataSource.getCurrentSupabaseUser();
    if (user == null) return null;
    return _buildUserEntity(user.id, user.email!);
  }
}