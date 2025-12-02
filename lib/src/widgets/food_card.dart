import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kTextColor = Color(0xFF333333);

class FoodCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const FoodCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isNetworkImage = imageUrl.startsWith('http');

    return Container( // Widget: Container — Uso: Tarjeta principal con borde y sombra.
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded( // Widget: Expanded — Uso: La imagen ocupa el espacio disponible dentro de la tarjeta.
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: isNetworkImage
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor.withValues(alpha: 0.5),
                            strokeWidth: 2,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        );
                      },
                    )
                  : Image.asset(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[100],
                          child: const Icon(Icons.image_not_supported, color: Colors.grey),
                        );
                      },
                    ),
            ),
          ),

          Padding( // Widget: Padding — Uso: Espaciado interno para título, precio y botón.
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: kTextColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox( // Widget: SizedBox — Uso: Control de altura del botón 'Agregar'.
                  height: 35,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('Agregar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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

// Widget: Container — Uso: Tarjeta principal con borde y sombra.
// Widget: Column / Row — Uso: Organización vertical de imagen e información.
// Widget: Expanded / Flexible — Uso: La imagen ocupa el espacio disponible dentro de la tarjeta.
// Widget: Padding, Center, Align — Uso: Separación y centrado de indicadores de carga.
// Widget: SizedBox — Uso: Control de altura del botón y espacios entre elementos.
// Widget: ElevatedButton — Uso: Botón 'Agregar' para añadir el producto al carrito.