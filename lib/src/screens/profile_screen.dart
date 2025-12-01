import 'package:flutter/material.dart';
import '../widgets/profile_header.dart'; // <--- 1. Importamos el nuevo widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // 2. Usamos el widget separado. ¡Mucho más limpio!
            const ProfileHeader(),

            // -----------------------------------------------------------
            // TARJETA DE ESTADÍSTICAS
            // -----------------------------------------------------------
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(value: "12", label: "Pedidos"),
                    _VerticalDivider(),
                    _StatItem(value: "5", label: "Cupones"),
                    _VerticalDivider(),
                    _StatItem(value: "150", label: "Puntos"),
                  ],
                ),
              ),
            ),

            // -----------------------------------------------------------
            // OPCIONES DEL MENÚ
            // -----------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const _MenuTitle(title: "Cuentas"),
                  const _MenuOption(icon: Icons.person_outline, text: "Información Personal"),
                  const _MenuOption(icon: Icons.location_on_outlined, text: "Direcciones"),
                  const _MenuOption(icon: Icons.credit_card_outlined, text: "Métodos de Pago"),
                  
                  const SizedBox(height: 20),
                  const _MenuTitle(title: "Preferencias"),
                  const _MenuOption(icon: Icons.notifications_none_outlined, text: "Notificaciones", showBadge: true),
                  const _MenuOption(icon: Icons.language_outlined, text: "Idioma"),
                  
                  const SizedBox(height: 30),
                  
                  // Botón Cerrar Sesión
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.red.withValues(alpha: 0.05),
                      ),
                      child: const Center(
                        child: Text(
                          "Cerrar Sesión",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
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
  }
}

// --- WIDGETS AUXILIARES PRIVADOS (Se quedan aquí porque son específicos de esta pantalla) ---

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey[200],
    );
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
        padding: const EdgeInsets.only(bottom: 10, left: 10),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}

class _MenuOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showBadge;

  const _MenuOption({required this.icon, required this.text, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: showBadge 
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("2", style: TextStyle(color: Colors.white, fontSize: 10)),
            ) 
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ),
    );
  }
}