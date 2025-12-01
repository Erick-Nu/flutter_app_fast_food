import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import '../widgets/custom_drawer.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. DATOS: Lista de productos (Simulando una Base de Datos)
    final List<Map<String, dynamic>> products = [
      {
        "title": "Hamburguesa",
        "price": "\$5.50",
        "image": "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60",
      },
      {
        "title": "Pizza Familiar",
        "price": "\$12.00",
        "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60",
      },
      {
        "title": "Refresco",
        "price": "\$1.50",
        "image": "https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60",
      },
      {
        "title": "Papas Fritas",
        "price": "\$3.50",
        "image": "https://images.unsplash.com/photo-1630384031162-91847a68521e?auto=format&fit=crop&w=500&q=60",
      },
      {
        "title": "Hot Dog Especial",
        "price": "\$4.00",
        "image": "https://images.unsplash.com/photo-1612392062631-94dd85fa2dd8?auto=format&fit=crop&w=500&q=60",
      },
      {
        "title": "Donas Glaseadas",
        "price": "\$2.50",
        "image": "https://images.unsplash.com/photo-1551024601-bec78aea704b?auto=format&fit=crop&w=500&q=60",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Fondo suave
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              'FAST FOOD',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1.5),
            ),
            Text(
              'Delicioso & Rápido',
              style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w400),
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
                top: 12, right: 12,
                child: Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        toolbarHeight: 70,
      ),

      // 2. WIDGET GRIDVIEW.BUILDER (Aquí está la magia)
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          // Espaciado interno superior para que no se pegue al AppBar
          padding: const EdgeInsets.only(top: 20, bottom: 80), 
          
          // Cuántos elementos hay en total (longitud de la lista)
          itemCount: products.length,
          
          // Configuración de la rejilla
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,       // 2 Columnas
            mainAxisSpacing: 16,     // Espacio vertical entre tarjetas
            crossAxisSpacing: 16,    // Espacio horizontal entre tarjetas
            childAspectRatio: 0.75,  // Proporción (Alto vs Ancho) para que la tarjeta se vea bien
          ),
          
          // Constructor de cada tarjeta
          itemBuilder: (context, index) {
            final product = products[index];
            
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      title: product["title"],
                      price: product["price"],
                      imageUrl: product["image"],
                    ),
                  ),
                );
              },
              // Reutilizamos tu widget FoodCard
              child: FoodCard(
                title: product["title"],
                price: product["price"],
                imageUrl: product["image"],
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}