import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/config/supabase_client.dart';
import '../../../../core/utils/logger.dart';

abstract class AuthRemoteDataSource {
  Future<User> signIn(String email, String password);
  Future<User> signUp(String email, String password, String name);
  Future<void> signOut();
  User? getCurrentSupabaseUser();
  
  // Este método extrae los datos de TU tabla personalizada (puntos, nivel)
  Future<Map<String, dynamic>> getUserProfile(String userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<User> signIn(String email, String password) async {
    final response = await SupabaseConfig.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) throw Exception('Login falló');
    return response.user!;
  }

  @override
  Future<User> signUp(String email, String password, String name) async {
    final response = await SupabaseConfig.client.auth.signUp(
      email: email,
      password: password,
      data: {'nombre': name}, // Esto lo leerá el Trigger SQL
    );
    if (response.user == null) throw Exception('Registro falló');
    return response.user!;
  }

  @override
  Future<void> signOut() async {
    await SupabaseConfig.client.auth.signOut();
  }

  @override
  User? getCurrentSupabaseUser() {
    return SupabaseConfig.client.auth.currentUser;
  }

  @override
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      // Consultamos la VISTA INTELIGENTE que creamos antes
      final data = await SupabaseConfig.client
          .from('perfil_completo_usuario')
          .select()
          .eq('id', userId)
          .single();
      return data;
    } catch (e) {
      logger.e('Error leyendo perfil de usuario', error: e);
      // Si falla (ej: el trigger falló), devolvemos datos básicos
      return {'puntos': 0, 'nombre_nivel': 'Novato'}; 
    }
  }
}