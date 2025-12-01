import 'package:flutter/material.dart';

// Definimos el color aquí para que el widget sea autónomo
const Color kPrimaryColor = Color(0xFFD32F2F); 
const Color kDarkRed = Color(0xFFB71C1C);

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      decoration: const BoxDecoration(
        // GRADIENTE DE MARCA (Rojo Pizzería)
        gradient: LinearGradient(
          colors: [kPrimaryColor, kDarkRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          // FOTO DE PERFIL
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2), // Borde translúcido
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 55, // Un poco más grande
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
              ),
            ),
          ),
          const SizedBox(height: 15),
          
          // NOMBRE
          const Text(
            "Erick Nu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // INSIGNIA (Estilo "Pizza Lover")
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.local_pizza, color: Colors.orange, size: 16),
                SizedBox(width: 5),
                Text(
                  "Pizza Master", // Rango personalizado
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}