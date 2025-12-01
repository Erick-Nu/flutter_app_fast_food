import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import '../widgets/custom_drawer.dart';
import 'product_detail_screen.dart'; // Importamos la pantalla de detalle

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menú Lateral (Drawer)
      drawer: const CustomDrawer(),

      // Barra Superior (AppBar) con Diseño Profesional
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'FAST FOOD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'Delicioso & Rápido',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        toolbarHeight: 70,
      ),

      // Cuerpo Principal (Grid de Productos)
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Dos columnas
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75, // Proporción de las tarjetas
          children: [
            // --- PRODUCTO 1: Hamburguesa ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(
                      title: 'Hamburguesa',
                      price: '\$5.50',
                      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60',
                    ),
                  ),
                );
              },
              child: const FoodCard(
                title: 'Hamburguesa',
                price: '\$5.50',
                imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60',
              ),
            ),

            // --- PRODUCTO 2: Pizza ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(
                      title: 'Pizza Familiar',
                      price: '\$12.00',
                      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60',
                    ),
                  ),
                );
              },
              child: const FoodCard(
                title: 'Pizza Familiar',
                price: '\$12.00',
                imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60',
              ),
            ),

            // --- PRODUCTO 3: Refresco ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(
                      title: 'Refresco',
                      price: '\$1.50',
                      imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60',
                    ),
                  ),
                );
              },
              child: const FoodCard(
                title: 'Refresco',
                price: '\$1.50',
                imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60',
              ),
            ),

            // --- PRODUCTO 4: Papas Fritas ---
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(
                      title: 'Papas Fritas',
                      price: '\$3.50',
                      imageUrl: 'https://images.unsplash.com/photo-1630384031162-91847a68521e?auto=format&fit=crop&w=500&q=60',
                    ),
                  ),
                );
              },
              child: const FoodCard(
                title: 'Papas Fritas',
                price: '\$3.50',
                imageUrl: 'https://images.unsplash.com/photo-1630384031162-91847a68521e?auto=format&fit=crop&w=500&q=60',
              ),
            ),
          ],
        ),
      ),

      // Botón Flotante (Filtro)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}