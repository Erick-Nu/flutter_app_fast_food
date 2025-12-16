import '../entities/user_entity.dart';

abstract class AuthRepository {
  // Entrar con Email y Contraseña
  Future<UserEntity> signIn(String email, String password);
  
  // Registrarse (Necesitamos el nombre para la tabla usuarios)
  Future<UserEntity> signUp(String email, String password, String name);
  
  // Cerrar Sesión
  Future<void> signOut();
  
  // Obtener usuario actual (si ya está logueado)
  Future<UserEntity?> getCurrentUser();
}