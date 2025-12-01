import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Le damos bordes redondeados al drawer para un toque moderno
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: ListView(
        // removePadding elimina el espacio blanco superior por defecto
        padding: EdgeInsets.zero,
        children: [
          // 1. CABECERA DEL USUARIO (UserAccountsDrawerHeader)
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1550989460-0adf9ea622e2?q=80&w=600&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
                opacity: 0.8, // Oscurece un poco la imagen de fondo
              ),
            ),
            accountName: const Text(
              "Erick Nu",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text("erick@fastfood.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "EN",
                style: TextStyle(fontSize: 24, color: Colors.deepPurple[800]),
              ),
            ),
          ),

          // 2. OPCIONES DEL MENÚ
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined, color: Colors.deepPurple),
            title: const Text('Mis Pedidos'),
            onTap: () {
              // Cerrar el drawer antes de navegar
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer_outlined, color: Colors.deepPurple),
            title: const Text('Cupones & Ofertas'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Nuevo',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline, color: Colors.deepPurple),
            title: const Text('Favoritos'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          
          const Divider(), // Línea divisoria
          
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: Colors.grey),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.grey),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              // Lógica de logout
            },
          ),
        ],
      ),
    );
  }
}