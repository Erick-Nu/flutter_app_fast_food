import 'package:flutter/material.dart';
import '../../../../core/config/injection.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/utils/logger.dart';

class AuthProvider extends ChangeNotifier {
  UserEntity? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuth => _currentUser != null; // Para saber rápido si está logueado
  String? get errorMessage => _errorMessage;

  final AuthRepository _repository = sl<AuthRepository>();

  // Verificar sesión al abrir la app
  Future<void> checkSession() async {
    try {
      _currentUser = await _repository.getCurrentUser();
      if (_currentUser != null) {
        logger.i('Sesión recuperada: ${_currentUser!.name} (${_currentUser!.levelName})');
      }
    } catch (e) {
      _currentUser = null;
    }
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _repository.signIn(email, password);
      logger.i('Login exitoso: ${_currentUser!.name}');
      return true; // Éxito
    } catch (e) {
      logger.e('Error en Login', error: e);
      _errorMessage = 'Credenciales incorrectas';
      return false; // Falló
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _repository.signUp(email, password, name);
      logger.i('Registro exitoso: ${_currentUser!.name}');
      return true;
    } catch (e) {
      logger.e('Error en Registro', error: e);
      _errorMessage = 'No se pudo crear la cuenta';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _currentUser = null;
    notifyListeners();
  }
}