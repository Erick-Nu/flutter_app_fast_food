import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/config/supabase_client.dart';

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

  @override
  Future<void> sendPasswordRecovery(String email) async {
    try {
      final baseUrl = SupabaseConfig.supabaseUrl;
      final apiKey = SupabaseConfig.supabaseAnonKey;

      const redirectUrl = 'https://web-page-app-fast-food.vercel.app/reset-password';

      final uri = Uri.parse('$baseUrl/auth/v1/recover');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'apikey': apiKey,
        },
        body: jsonEncode({
          'email': email,
          'redirect_to': redirectUrl,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Error Supabase: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error al enviar recuperación: $e');
    }
  }
}