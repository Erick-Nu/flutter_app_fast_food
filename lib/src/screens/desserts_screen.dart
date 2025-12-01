import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui'; 
import '../widgets/food_card.dart';

// --- COLORES MEJORADOS ---
const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kPrimaryDark = Color(0xFFB71C1C);
const Color kAccentColor = Color(0xFFE57373); // Un rojo más claro para los círculos
const Color kBackgroundColor = Color(0xFFF5F5F7); // Gris muy suave, más moderno
const Color kTextColor = Color(0xFF1F1F1F);

class DessertsScreen extends StatelessWidget {
  const DessertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo
    final List<Map<String, dynamic>> desserts = [
      {
        "title": "Tiramisú Real",
        "price": "\$6.50",
        "image": "https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?q=80&w=500&auto=format&fit=crop",
      },
      {
        "title": "Cheesecake Fresa",
        "price": "\$5.00",
        "image": "https://images.unsplash.com/photo-1524351199678-941a58a3df50?q=80&w=500&auto=format&fit=crop",
      },
      {
        "title": "Cannoli Siciliano",
        "price": "\$4.50",
        "image": "https://images.unsplash.com/photo-1488477181946-6428a0291777?q=80&w=500&auto=format&fit=crop",
      },
      {
        "title": "Brownie Deluxe",
        "price": "\$7.00",
        "image": "https://images.unsplash.com/photo-1624353365286-3f8d62daad51?q=80&w=500&auto=format&fit=crop",
      },
      {
        "title": "Gelato Artesanal",
        "price": "\$3.50",
        "image": "https://images.unsplash.com/photo-1560008581-09826d1de69e?q=80&w=500&auto=format&fit=crop",
      },
      {
        "title": "Panna Cotta",
        "price": "\$6.00",
        "image": "https://images.unsplash.com/photo-1488477181946-6428a0291777?q=80&w=500&auto=format&fit=crop",
      },
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ---------------------------------------------------------
          // 1. APPBAR REDISEÑADO (Más compacto y con decoración)
          // ---------------------------------------------------------
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: kPrimaryColor,
            expandedHeight: 140.0, // REDUCIDO: De 180 a 140 para quitar espacio vacío
            floating: false,
            pinned: true,
            elevation: 0,
            
            // Botón Regresar
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            
            // Icono de "Me gusta" a la derecha
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              )
            ],

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 50), // Ajuste fino del texto
              title: const Text(
                "Postres & Dulces",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Tamaño más sutil
                  letterSpacing: 0.5,
                ),
              ),
              background: Stack(
                children: [
                  // 1. Fondo Gradiente (Para dar profundidad)
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [kPrimaryColor, kPrimaryDark],
                      ),
                    ),
                  ),
                  
                  // 2. Decoración: Círculo grande translúcido (Arriba Derecha)
                  // Esto rompe el color plano "feo"
                  Positioned(
                    top: -60,
                    right: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1), // Transparencia sutil
                      ),
                    ),
                  ),

                  // 3. Decoración: Círculo pequeño (Abajo Izquierda)
                  Positioned(
                    bottom: 20,
                    left: -30,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),

                  // 4. Decoración: Icono gigante de fondo (Efecto Watermark)
                  Positioned(
                    bottom: -20,
                    right: 40,
                    child: Transform.rotate(
                      angle: -0.2, // Ligeramente inclinado
                      child: Icon(
                        Icons.cake, 
                        size: 100, 
                        color: Colors.white.withValues(alpha: 0.1), // Apenas visible
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Curva inferior más sutil y limpia
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                height: 20,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),

          // ---------------------------------------------------------
          // 2. BUSCADOR (Mejorado visualmente)
          // ---------------------------------------------------------
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                children: [
                  // Barra de búsqueda con sombra suave
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar postre favorito...",
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: kPrimaryColor), // Icono rojo
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Categorías
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildCategoryChip("Todos", true),
                        _buildCategoryChip("Pasteles", false),
                        _buildCategoryChip("Fríos", false),
                        _buildCategoryChip("Sin Azúcar", false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ---------------------------------------------------------
          // 3. GRID DE PRODUCTOS
          // ---------------------------------------------------------
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 15,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOutQuad,
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: FoodCard(
                      title: desserts[index]["title"],
                      price: desserts[index]["price"],
                      imageUrl: desserts[index]["image"],
                    ),
                  );
                },
                childCount: desserts.length,
              ),
            ),
          ),
          
          // Espacio extra al final para scroll
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
            decoration: BoxDecoration(
              color: isSelected ? kPrimaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              // Borde sutil si no está seleccionado
              border: isSelected ? null : Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}