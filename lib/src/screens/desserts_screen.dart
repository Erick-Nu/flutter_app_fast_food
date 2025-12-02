import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../widgets/food_card.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kPrimaryDark = Color(0xFFB71C1C);
const Color kAccentColor = Color(0xFFE57373);
const Color kBackgroundColor = Color(0xFFF5F5F7);
const Color kTextColor = Color(0xFF1F1F1F);

class DessertsScreen extends StatelessWidget {
  const DessertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold( // Widget: Scaffold — Uso: Contenedor principal con CustomScrollView.
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        // Widget: CustomScrollView — Uso: Contenedor con Slivers para cabecera y grid.
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar( // Widget: SliverAppBar — Uso: Cabecera flexible con título y acciones.
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: kPrimaryColor,
            expandedHeight: 140.0,
            floating: false,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              )
            ],

            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 50),
              title: Text(
                "Postres & Dulces",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
              background: Stack(
                children: [],
              ),
            ),

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

          SliverToBoxAdapter( // Widget: SliverToBoxAdapter + TextField — Uso: Campo de búsqueda encima del grid.
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Column(
                children: [
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
                        prefixIcon: Icon(Icons.search, color: kPrimaryColor),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  SizedBox( // Widget: SizedBox — Uso: Lista horizontal de chips de categoría.
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

          SliverPadding( // Widget: SliverGrid — Uso: Grid de `FoodCard` para mostrar postres.
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
                    child: FoodCard( // Widget: FoodCard — Uso: Tarjeta individual de producto en el grid.
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

// Widget: Scaffold — Uso: Contenedor principal con CustomScrollView.
// Widget: AppBar (SliverAppBar) — Uso: Cabecera flexible con título y acciones.
// Widget: Stack — Uso: Superposición de decoraciones y elementos de fondo.
// Widget: Container — Uso: Fondos, chips y campos de búsqueda con estilo.
// Widget: ListView — Uso: Lista horizontal de categorías.
// Widget: GridView — Uso: Grid (SliverGrid) para mostrar productos.
// Widget: TextField — Uso: Campo de búsqueda para filtrar postres.