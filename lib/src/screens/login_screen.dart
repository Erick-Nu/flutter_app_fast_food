import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores de texto
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController(); // Solo para registro
  
  bool _isLogin = true; // Alternar entre Login y Registro

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o Icono
              const Icon(Icons.local_pizza, size: 80, color: Color(0xFFD32F2F)),
              const SizedBox(height: 20),
              Text(
                _isLogin ? "¡Bienvenido de nuevo!" : "Únete al Club",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Campo Nombre (Solo si es Registro)
              if (!_isLogin)
                TextField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    labelText: "Nombre completo",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
              if (!_isLogin) const SizedBox(height: 15),

              // Campo Email
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),

              // Campo Password
              TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),

              // Mensaje de Error
              if (authProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(authProvider.errorMessage!, style: const TextStyle(color: Colors.red)),
                ),

              // Botón Principal
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: authProvider.isLoading ? null : () async {
                    bool success;
                    if (_isLogin) {
                      success = await authProvider.signIn(_emailCtrl.text, _passCtrl.text);
                    } else {
                      success = await authProvider.signUp(_emailCtrl.text, _passCtrl.text, _nameCtrl.text);
                    }
                    
                    if (success && mounted) {
                      // Si funcionó, cerramos la pantalla de Login para volver al Perfil
                      // Ojo: En clean architecture puro usaríamos un router, 
                      // pero por ahora esto funciona perfecto para cambiar de estado.
                    }
                  },
                  child: authProvider.isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(_isLogin ? "INICIAR SESIÓN" : "REGISTRARSE", style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Switch Login/Registro
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
                    authProvider.notifyListeners(); // Limpiar errores
                  });
                },
                child: Text(
                  _isLogin ? "¿No tienes cuenta? Regístrate" : "¿Ya tienes cuenta? Ingresa",
                  style: const TextStyle(color: Color(0xFFD32F2F)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}