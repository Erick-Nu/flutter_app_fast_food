import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../screens/login_screen.dart'; // Importamos tu Login
import '../widgets/profile_header.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos al AuthProvider
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        
        // 1. SI NO ESTÁ LOGUEADO -> Muestra pantalla de Login
        if (!authProvider.isAuth) {
          return const LoginScreen();
        }

        // 2. SI SÍ ESTÁ LOGUEADO -> Muestra el Perfil Real
        final user = authProvider.currentUser!;

        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Header Dinámico con datos del Usuario
                ProfileHeader(
                  name: user.name,
                  email: user.email,
                  level: user.levelName, // "Pizza Love", "Novato", etc.
                ),

                Transform.translate(
                  offset: const Offset(0, -25),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(value: "0", label: "Pedidos"), // Podrías conectar esto a pedidos después
                        const _VerticalDivider(),
                        _StatItem(value: "0", label: "Cupones"),
                        const _VerticalDivider(),
                        // PUNTOS REALES
                        _StatItem(value: user.points.toString(), label: "Puntos"),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      const _MenuTitle(title: "Mi Cuenta"),
                      const _MenuOption(icon: Icons.person_outline, text: "Datos Personales"),
                      const _MenuOption(icon: Icons.location_on_outlined, text: "Direcciones de Entrega"),
                      const _MenuOption(icon: Icons.credit_card, text: "Métodos de Pago"),

                      const SizedBox(height: 25),
                      const _MenuTitle(title: "Soporte & Más"),
                      const _MenuOption(icon: Icons.help_outline, text: "Ayuda y Soporte"),
                      
                      const SizedBox(height: 35),

                      // BOTÓN CERRAR SESIÓN REAL
                      InkWell(
                        onTap: () {
                          // Llamamos al método de salir
                          authProvider.signOut();
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.logout, color: kPrimaryColor, size: 20),
                              SizedBox(width: 10),
                              Text(
                                "Cerrar Sesión",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- WIDGETS AUXILIARES (Sin cambios, solo copia y pega para que funcione) ---
class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: kPrimaryColor)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 35, color: Colors.grey[200]);
  }
}

class _MenuTitle extends StatelessWidget {
  final String title;
  const _MenuTitle({required this.title});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 5),
        child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800])),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MenuOption({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: kPrimaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: kPrimaryColor, size: 22),
        ),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      ),
    );
  }
}