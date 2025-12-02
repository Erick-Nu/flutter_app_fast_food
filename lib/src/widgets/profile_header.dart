import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kDarkRed = Color(0xFFB71C1C);

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container( // Widget: Container — Uso: Fondo con gradiente y sombra para el header.
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor, kDarkRed],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Column(
        children: [
          Container( // Widget: Container — Uso: Borde y fondo alrededor del avatar.
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80'),
            ),
          ),
          const SizedBox(height: 15),

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

          Container( // Widget: Container — Uso: Badge/insignia debajo del nombre (Pizza Master).
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
                  "Pizza Master",
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

// Widget: Container — Uso: Fondo con gradiente y sombra para el header.
// Widget: Column / Row — Uso: Organización vertical del avatar, nombre e insignia.
// Widget: SizedBox — Uso: Espacios verticales entre elementos del header.