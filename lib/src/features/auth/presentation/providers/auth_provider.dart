import 'package:flutter/material.dart';
import '../../../../core/config/injection.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/logger.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository = sl<AuthRepository>();

  AuthStatus _status = AuthStatus.checking;
  UserEntity? _currentUser;
  String? _errorMessage;

  AuthStatus get status => _status;
  bool get isAuth => _status == AuthStatus.authenticated;
  UserEntity? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == AuthStatus.checking;

  Future<void> checkSession() async {
    try {
      final user = await _repository.getCurrentUser();
      if (user != null) {
        _currentUser = user;
        _status = AuthStatus.authenticated;
        logger.i('Sesión recuperada: ${user.name}');
      } else {
        _status = AuthStatus.unauthenticated;
      }
    } catch (e) {
      logger.e('Error verificando sesión', error: e);
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _status = AuthStatus.checking;
    notifyListeners();

    try {
      _currentUser = await _repository.signIn(email, password);
      _errorMessage = null;
      _status = AuthStatus.authenticated; // ¡Esto cambiará la pantalla en main.dart!
      logger.i('Login exitoso: ${_currentUser!.name}');
    } catch (e) {
      logger.e('Error en Login', error: e);
      _errorMessage = 'Credenciales incorrectas';
      _status = AuthStatus.unauthenticated; // Regresamos al login si falla
    }
    notifyListeners();
  }

  Future<void> signUp(String email, String password, String name) async {
    _status = AuthStatus.checking;
    notifyListeners();

    try {
      _currentUser = await _repository.signUp(email, password, name);
      _errorMessage = null;
      _status = AuthStatus.authenticated; // ¡Esto cambiará la pantalla en main.dart!
      logger.i('Registro exitoso: ${_currentUser!.name}');
    } catch (e) {
      logger.e('Error en Registro', error: e);
      _errorMessage = 'No se pudo crear la cuenta. Intenta con otro correo.';
      _status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _currentUser = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}