import 'package:flutter/material.dart';

// Colores locales para que el widget sea autónomo
const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kTextColor = Color(0xFF333333);

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
    // Lógica para detectar tipo de imagen
    final isNetworkImage = imageUrl.startsWith('http');

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Sombra difusa de alta calidad
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 1. IMAGEN (Con soporte robusto de carga)
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 90,
                height: 90,
                child: isNetworkImage
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor.withValues(alpha: 0.3),
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      )
                    : Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        ),
                      ),
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
                      color: kTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800, // Más peso visual
                      color: kPrimaryColor, // Rojo Pizzería
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // 3. CONTROLES DE CANTIDAD
                  Row(
                    children: [
                      _QuantityBtn(icon: Icons.remove, onTap: onRemove),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 16,
                            color: kTextColor
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

// Botones de cantidad (Privado)
class _QuantityBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isActive;

  const _QuantityBtn({required this.icon, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            // Rojo si es activo (+), Gris claro si es inactivo (-)
            color: isActive ? kPrimaryColor : const Color(0xFFF5F5F5),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon, 
            size: 18, 
            // Icono blanco si es activo, gris oscuro si no
            color: isActive ? Colors.white : const Color(0xFF666666)
          ),
        ),
      ),
    );
  }
}