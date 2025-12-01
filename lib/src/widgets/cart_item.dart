import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final int quantity;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
    this.onAdd,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Sombra muy sutil y difusa (Estilo Apple/Moderno)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 1. IMAGEN CON BORDES SUAVES
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            
            const SizedBox(width: 16),

            // 2. INFORMACIÓN Y CONTROLES
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple[400],
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // 3. CONTROLES DE CANTIDAD (Estilo "Pill")
                  Row(
                    children: [
                      _QuantityBtn(icon: Icons.remove, onTap: onRemove),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 15
                          ),
                        ),
                      ),
                      _QuantityBtn(icon: Icons.add, onTap: onAdd, isActive: true),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget privado para los botoncitos redondos
class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;

  const _QuantityBtn({required this.icon, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isActive ? Colors.deepPurple : Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon, 
          size: 16, 
          color: isActive ? Colors.white : Colors.black87
        ),
      ),
    );
  }
}