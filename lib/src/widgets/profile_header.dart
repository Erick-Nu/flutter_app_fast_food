import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  // Ahora recibimos los datos reales
  final String name;
  final String email;
  final String level;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        color: Color(0xFFD32F2F), // kPrimaryColor
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Avatar
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"), // Avatar genérico o user.image
            ),
          ),
          const SizedBox(height: 10),
          // Nombre Real
          Text(
            name, 
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          // Email
          Text(
            email, 
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          // Nivel (Badge)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium, size: 16, color: Colors.black87),
                const SizedBox(width: 4),
                Text(
                  level, // Ej: "Pizza Love"
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}