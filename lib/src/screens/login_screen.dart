import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  
  bool _isLogin = true;

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
              const Icon(Icons.local_pizza, size: 80, color: Color(0xFFD32F2F)),
              const SizedBox(height: 20),
              Text(
                _isLogin ? "¡Bienvenido de nuevo!" : "Únete al Club",
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

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

              Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ResetPasswordScreen(),
                    ),
                  );
                },
                child: Text("¿Olvidaste tu contraseña?", 
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold) // Usa tu kPrimaryColor
                ),
              ),
              ),

              if (authProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    authProvider.errorMessage!, 
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    if (_isLogin) {
                      authProvider.signIn(_emailCtrl.text, _passCtrl.text);
                    } else {
                      authProvider.signUp(_emailCtrl.text, _passCtrl.text, _nameCtrl.text);
                    }
                  },
                  child: Text(
                    _isLogin ? "INICIAR SESIÓN" : "REGISTRARSE", 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLogin = !_isLogin;
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