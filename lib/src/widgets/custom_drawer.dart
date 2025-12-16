import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kTextColor = Color(0xFF333333);

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( // Widget: Drawer — Uso: Panel lateral de navegación con avatar y opciones.
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20), // Widget: Container — Uso: Cabecera decorada del drawer (avatar y datos).
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [kPrimaryColor, Color(0xFFB71C1C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=200&auto=format&fit=crop'),
                  ),
                ),
                const SizedBox(height: 15),
                const Text("Hola, Erick", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const Text("erick@fastfood.com", style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),

          Expanded( // Widget: Expanded + ListView — Uso: Lista desplazable de opciones del drawer.
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _DrawerItem(icon: Icons.receipt_long_outlined, text: 'Mis Pedidos', onTap: () => Navigator.pop(context)),
                _DrawerItem(icon: Icons.local_offer_outlined, text: 'Cupones', badge: '2 Nuevos', onTap: () => Navigator.pop(context)),
                _DrawerItem(icon: Icons.favorite_border, text: 'Favoritos', onTap: () => Navigator.pop(context)),
                _DrawerItem(icon: Icons.location_on_outlined, text: 'Direcciones', onTap: () => Navigator.pop(context)),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Divider()),
                _DrawerItem(icon: Icons.settings_outlined, text: 'Configuración', iconColor: Colors.grey, onTap: () => Navigator.pop(context)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.red[50], borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, color: kPrimaryColor),
                    SizedBox(width: 10),
                    Text("Cerrar Sesión", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final String? badge;
  final Color iconColor;

  const _DrawerItem({required this.icon, required this.text, required this.onTap, this.badge, this.iconColor = kPrimaryColor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: kTextColor)),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Text(badge!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            )
          : const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}

// Widget: Drawer — Uso: Panel lateral de navegación con avatar y opciones.
// Widget: Column / Row — Uso: Organización vertical y horizontal dentro del drawer.
// Widget: Container — Uso: Cabecera decorada y elementos con padding.
// Widget: Padding — Uso: Separación entre secciones y para el Divider.
// Widget: ListView — Uso: Lista desplazable de opciones dentro del drawer.
// Widget: SizedBox — Uso: Espacio entre elementos (avatar, textos, botones).