import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
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
      height: 310, // <--- AUMENTADO para arreglar el problema visual
      decoration: const BoxDecoration(
        color: Color(0xFFD32F2F), 
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20), 
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: const CircleAvatar(
              radius: 45, 
              backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=11"),
            ),
          ),
          const SizedBox(height: 10),
          Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(email, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 15),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.amber, 
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.workspace_premium, size: 18, color: Colors.black87),
                const SizedBox(width: 5),
                Text(level, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              ],
            ),
          ),
          const SizedBox(height: 25), // Espacio extra abajo
        ],
      ),
    );
  }
}