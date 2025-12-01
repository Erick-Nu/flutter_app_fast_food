import 'package:flutter/material.dart';
import '../widgets/food_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AQUÍ ESTÁ EL SCAFFOLD: El widget raíz de la pantalla
    return Scaffold(
      // 1. EL APPBAR (Arriba)
      appBar: AppBar(
        title: const Text(
          'Menú del Día',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),

      // 2. EL BODY (Centro - Contenido Principal)
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
          children: const [
            FoodCard(
              title: 'Hamburguesa',
              price: '\$5.50',
              imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=500&q=60',
            ),
            FoodCard(
              title: 'Pizza',
              price: '\$12.00',
              imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=500&q=60',
            ),
            FoodCard(
              title: 'Refresco',
              price: '\$1.50',
              imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?auto=format&fit=crop&w=500&q=60',
            ),
            FoodCard(
              title: 'Papas Fritas',
              price: '\$3.50',
              imageUrl: 'https://images.unsplash.com/photo-1630384031162-91847a68521e?auto=format&fit=crop&w=500&q=60',
            ),
          ],
        ),
      ),

      // 3. FLOATING ACTION BUTTON (Botón Flotante - Nueva adición)
      // El Scaffold se encarga de ponerlo en la esquina inferior derecha automáticamente.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Filtrar comida");
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}