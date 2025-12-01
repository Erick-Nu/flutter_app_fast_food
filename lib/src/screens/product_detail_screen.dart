import 'package:flutter/material.dart';

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
          // PARTE SUPERIOR (Fija): Imagen y Encabezado
          // ---------------------------------------------------------
          SizedBox(
            height: size.height * 0.45,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Hero(
                    tag: title,
                    child: Image.network(imageUrl, fit: BoxFit.cover),
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
                          Colors.black.withValues(alpha: 0.1),
                        ],
                        stops: const [0.0, 0.4, 1.0],
                      ),
                    ),
                  ),
                ),
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
          // PARTE INFERIOR (Flexible): Panel Blanco
          // ---------------------------------------------------------
          // Usamos Expanded aquí para que el panel blanco ocupe TODO el 
          // espacio que sobra debajo de la imagen.
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)), 
              ),
              transform: Matrix4.translationValues(0, -30, 0),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- ELEMENTOS FIJOS SUPERIORES ---
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
                    children: [
                      Expanded( // Para que el título no empuje al precio si es muy largo
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.w900, 
                          color: Colors.deepPurple
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),

                  // Barra Nutricional
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        const Expanded(child: _NutriInfo(label: "Kcal", value: "450", icon: Icons.local_fire_department)),
                        Container(height: 30, width: 1, color: Colors.grey[300]),
                        const Expanded(child: _NutriInfo(label: "Proteína", value: "30g", icon: Icons.fitness_center)),
                        Container(height: 30, width: 1, color: Colors.grey[300]),
                        const Expanded(child: _NutriInfo(label: "Tiempo", value: "20'", icon: Icons.timer)),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  Text(
                    "Descripción",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 8),

                  // --- ELEMENTO EXPANDIDO (EL RESORTE) ---
                  // Este Expanded es CLAVE. Le dice al texto: "Ocupa todo el espacio
                  // que quede libre entre el título 'Descripción' y el botón de abajo".
                  Expanded(
                    child: SingleChildScrollView(
                      // Ponemos BouncingScrollPhysics para que se sienta nativo en iOS
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        "Esta deliciosa opción está preparada con carne 100% Angus importada, seleccionada cuidadosamente para garantizar la mejor calidad. \n\nAcompañada de queso cheddar fundido artesanalmente que se derrite en tu boca, cebolla caramelizada cocinada a fuego lento durante 4 horas para obtener ese dulzor natural perfecto, y nuestra salsa secreta de la casa con un toque ahumado que no encontrarás en ningún otro lugar.\n\nTodo esto servido en un pan brioche horneado el mismo día, suave y dorado. ¡Una experiencia que tienes que probar para creer!",
                        style: TextStyle(color: Colors.grey[600], height: 1.6, fontSize: 15),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 10),

                  // --- ELEMENTO FIJO INFERIOR (El Botón) ---
                  // Al estar después del Expanded, este botón siempre se dibujará
                  // pegado al fondo del contenedor padre.
                  SafeArea(
                    top: false, // Solo nos importa el safe area de abajo (para iPhone X+)
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: Colors.deepPurple.withValues(alpha: 0.4),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text(
                          "Añadir al Carrito",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        Icon(icon, size: 20, color: Colors.orange),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}