import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Widget: Scaffold — Uso: Estructura principal de la pantalla con `backgroundColor` y `body`.
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        // Widget: SingleChildScrollView — Uso: Permite scroll vertical con rebote.
        physics: const BouncingScrollPhysics(),
        child: Column(
          // Widget: Column — Uso: Organiza widgets verticalmente (header, tarjetas, opciones).
          children: [
            const ProfileHeader(), // Widget: ProfileHeader — Uso: Header con avatar, nombre y badge.

            Transform.translate(
              // Widget: Transform.translate — Uso: Ajusta la posición del panel principal para superponer con el header.
              offset: const Offset(0, -25),
              child: Container(
                // Widget: Container — Uso: Tarjeta con estadísticas (Pedidos, Cupones, Puntos).
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _StatItem(value: "15", label: "Pedidos"),
                    _VerticalDivider(),
                    _StatItem(value: "3", label: "Cupones"),
                    _VerticalDivider(),
                    _StatItem(value: "240", label: "Puntos"),
                  ],
                ),
              ),
            ),

            Padding( // Widget: Padding — Uso: Espaciado alrededor del bloque de opciones y títulos.
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
                  const _MenuOption(icon: Icons.notifications_none, text: "Notificaciones", showBadge: true),

                  const SizedBox(height: 35),

                  InkWell( // Widget: InkWell — Uso: Área táctil para 'Cerrar Sesión' con efecto ripple.
                    onTap: () {},
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      // Widget: Container — Uso: Botón visual para cerrar sesión.
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
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
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: kPrimaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
        ),
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
      height: 35,
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
        padding: const EdgeInsets.only(bottom: 15, left: 5),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey[800]),
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
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: kPrimaryColor, size: 22),
        ),
        title: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        trailing: showBadge
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text("2", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              )
            : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      ),
    );
  }
}

// Widget: Scaffold — Uso: Provee la estructura principal de la pantalla con `backgroundColor` y `body`.
// Widget: Column / Row — Uso: Organiza widgets vertical u horizontalmente en esta pantalla.
// Widget: Container — Uso: Contenedores decorativos para tarjetas y secciones.
// Widget: Padding — Uso: Añade separación interna alrededor de widgets.
// Widget: Align — Uso: Alinea títulos y subtítulos dentro de la UI.
// Widget: SizedBox — Uso: Añade espacios verticales u horizontales entre elementos.