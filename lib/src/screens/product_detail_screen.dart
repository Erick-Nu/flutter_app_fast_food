import 'package:flutter/material.dart';

// --- COLORES DE LA MARCA ---
const Color kPrimaryColor = Color(0xFFD32F2F); // Rojo Pizzería
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

    return Scaffold(
      extendBodyBehindAppBar: true, 
      body: Column(
        children: [
          // ---------------------------------------------------------
          // 1. IMAGEN HERO CON BOTONES (Parte Superior)
          // ---------------------------------------------------------
          SizedBox(
            height: size.height * 0.45,
            child: Stack(
              children: [
                // Fondo: Imagen
                Positioned.fill(
                  child: Hero(
                    tag: title, // Animación suave
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(color: Colors.grey[300], child: const Icon(Icons.local_pizza, size: 50, color: Colors.grey));
                      },
                    ),
                  ),
                ),
                
                // Capa: Gradiente para que los botones se vean
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6), // Oscuro arriba
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.2), // Sutil abajo
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),

                // Botones Flotantes (Atrás y Favorito)
                SafeArea(
                  child: Padding(
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
          
          // ---------------------------------------------------------
          // 2. PANEL DE INFORMACIÓN (Blanco y Curvo)
          // ---------------------------------------------------------
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)), 
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))
                ],
              ),
              // Subimos el panel 30px para tapar ligeramente la imagen
              transform: Matrix4.translationValues(0, -30, 0),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Barra gris para indicar "deslizable" visualmente
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
                  
                  // Título y Precio
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
                          color: kPrimaryColor // Precio en ROJO
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 25),

                  // Barra Nutricional (Datos de la Pizza)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[50], // Fondo muy suave
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

                  // Descripción con Scroll (Expanded)
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

                  // ---------------------------------------------------------
                  // 3. BOTÓN DE ACCIÓN (Rojo Intenso)
                  // ---------------------------------------------------------
                  SafeArea(
                    top: false,
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor, // Botón ROJO
                          foregroundColor: Colors.white,
                          elevation: 8,
                          shadowColor: kPrimaryColor.withValues(alpha: 0.4), // Sombra roja brillante
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

// --- WIDGETS AUXILIARES ---

class _NutriInfo extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _NutriInfo({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Icono en naranja/rojo para combinar
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
          color: Colors.white.withValues(alpha: 0.25), // Cristal
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}