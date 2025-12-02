import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kTextColor = Color(0xFF333333);
const Color kWhiteColor = Colors.white;

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold( // Widget: Scaffold — Uso: Contenedor principal que aloja la imagen y el panel de detalle.
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          SizedBox( // Widget: SizedBox — Uso: Contenedor de altura fija para la imagen superior.
            height: size.height * 0.45,
            child: Stack(
              children: [
                Positioned.fill( // Widget: Positioned.fill + Hero — Uso: Imagen hero que ocupa la zona superior.
                  child: Hero(
                    tag: title,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[300], child: const Icon(Icons.local_pizza, size: 50, color: Colors.grey));
                      },
                    ),
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.2),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),

                SafeArea( // Widget: SafeArea — Uso: Protege los botones flotantes del área de notch/status bar.
                  child: Padding(
                    // Widget: Padding — Uso: Espacio alrededor de la fila de botones (back, favorite).
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CircularButton(
                          icon: Icons.arrow_back_ios_new,
                          onTap: () => Navigator.pop(context),
                        ),
                        _CircularButton(
                          icon: Icons.favorite_border,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded( // Widget: Expanded — Uso: Panel de detalle que ocupa el espacio restante.
            child: Container(
              // Widget: Container — Uso: Panel blanco con borde redondeado que contiene la info del producto.
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))
                ],
              ),
              transform: Matrix4.translationValues(0, -30, 0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50, height: 5,
                      margin: const EdgeInsets.only(top: 10, bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: kTextColor),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: _NutriInfo(label: "Kcal", value: "350", icon: Icons.local_fire_department)),
                        Container(height: 30, width: 1, color: Colors.grey[300]),
                        const Expanded(child: _NutriInfo(label: "Tamaño", value: "35cm", icon: Icons.straighten)),
                        Container(height: 30, width: 1, color: Colors.grey[300]),
                        const Expanded(child: _NutriInfo(label: "Tiempo", value: "20'", icon: Icons.timer)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Text(
                    "Ingredientes & Detalles",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        "Disfruta de la auténtica experiencia italiana con nuestra masa madre fermentada por 48 horas, crujiente por fuera y suave por dentro. \n\nBañada en nuestra salsa secreta de tomates San Marzano y cubierta generosamente con queso mozzarella premium que se derrite a la perfección. Cada ingrediente ha sido seleccionado fresco del mercado local para garantizar el sabor más intenso en cada mordida. \n\n¡Perfecta para compartir o disfrutar solo!",
                        style: TextStyle(color: Colors.grey[600], height: 1.6, fontSize: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SafeArea( // Widget: SafeArea — Uso: Protege el botón de acción inferior en dispositivos con gestos.
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton( // Widget: ElevatedButton — Uso: Botón principal para 'Añadir al Carrito'.
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: kPrimaryColor.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.shopping_bag_outlined, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Añadir al Carrito",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutriInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _NutriInfo({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 22, color: Colors.orange[800]),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: kTextColor)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircularButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.25),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

// Widget: Scaffold — Uso: Contenedor principal que aloja la imagen y el panel de detalle.
// Widget: Column / Row — Uso: Organiza la disposición vertical y horizontal de contenidos.
// Widget: Stack — Uso: Superpone imagen de fondo, gradiente y botones flotantes.
// Widget: Expanded / Flexible — Uso: Hace que el panel de información ocupe el espacio restante.
// Widget: Container — Uso: Paneles decorativos y contenedores con padding y borde.
// Widget: Padding, Center, Align — Uso: Alineación y separación de elementos visuales.
// Widget: SizedBox — Uso: Control de espacios y tamaños fijos para imagen y botones.
// Widget: ElevatedButton — Uso: Botón de acción para añadir al carrito.