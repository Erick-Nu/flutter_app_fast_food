import 'package:flutter/material.dart';
import 'product_detail_screen.dart';
import 'desserts_screen.dart';
import '../widgets/custom_drawer.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);
const Color kWhiteColor = Colors.white;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"icon": Icons.local_pizza, "label": "Clásicas"},
      {"icon": Icons.workspace_premium, "label": "Gourmet"},
      {"icon": Icons.eco, "label": "Veggie"},
      {"icon": Icons.local_drink, "label": "Bebidas"},
      {"icon": Icons.icecream, "label": "Postres"},
    ];

    final List<Map<String, dynamic>> popularPizzas = [
      {
        "title": "Pepperoni Lover",
        "ingredients": "Doble pepperoni crujiente, queso mozzarella fundido y salsa napolitana.",
        "price": "\$12.50",
        "image": "https://images.unsplash.com/photo-1628840042765-356cda07504e?q=80&w=500&auto=format&fit=crop",
        "rating": "4.8"
      },
      {
        "title": "Hawaiana Tropical",
        "ingredients": "Piña fresca dorada, jamón ahumado, queso y extra salsa de tomate.",
        "price": "\$11.00",
        "image": "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=500&auto=format&fit=crop",
        "rating": "4.5"
      },
      {
        "title": "Suprema de Carne",
        "ingredients": "Carne molida, pepperoni, salchicha italiana, tocino y pimientos.",
        "price": "\$14.00",
        "image": "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=500&auto=format&fit=crop",
        "rating": "4.9"
      },
      {
        "title": "Margarita Fresca",
        "ingredients": "Tomates cherry, albahaca fresca, aceite de oliva y mozzarella di bufala.",
        "price": "\$10.50",
        "image": "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?q=80&w=500&auto=format&fit=crop",
        "rating": "4.7"
      },
    ];

    return Scaffold( // Widget: Scaffold — Uso: Contenedor principal de la pantalla con `drawer` y `body`.
      backgroundColor: kBackgroundColor,
      drawer: const CustomDrawer(), // Widget: Drawer — Uso: Panel lateral de navegación (se usa `CustomDrawer`).
      body: Column( // Widget: Column — Uso: Organización de cabecera, listas y tarjetas verticalmente.
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25), // Widget: Container — Uso: Cabecera superior con fondo y búsqueda.
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 5))],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Entregar en:", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Row(
                          children: const [
                            Icon(Icons.location_on, color: kWhiteColor, size: 16),
                            SizedBox(width: 4),
                            Text("Casa - Calle 123", style: TextStyle(color: kWhiteColor, fontSize: 16, fontWeight: FontWeight.bold)),
                            Icon(Icons.keyboard_arrow_down, color: kWhiteColor, size: 18),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: kWhiteColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.notifications_outlined, color: kWhiteColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Container( // Widget: Container — Uso: Campo de búsqueda.
                  height: 50,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const TextField(
                    // Widget: TextField — Uso: Entrada de búsqueda en la cabecera.
                    decoration: InputDecoration(
                      hintText: "¿Qué pizza se te antoja?",
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 160,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=500&auto=format&fit=crop",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 50));
                                },
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(20)),
                                    child: const Text("PROMO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10)),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text("2x1 en Pizzas\nFamiliares", style: TextStyle(color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox( // Widget: SizedBox + ListView.builder — Uso: Carrusel horizontal de categorías.
                    height: 90,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final bool isSelected = index == 0;
                        final category = categories[index];

                        return GestureDetector(
                          onTap: () {
                            if (category["label"] == "Postres") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DessertsScreen(),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: isSelected ? kPrimaryColor : kWhiteColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5))],
                                  ),
                                  child: Icon(
                                    category["icon"],
                                    color: isSelected ? kWhiteColor : kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category["label"],
                                  style: TextStyle(
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected ? kPrimaryColor : Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding( // Widget: Padding — Uso: Título y botón 'Ver todo' para la sección.
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Más Populares", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
                        TextButton(onPressed: () {}, child: const Text("Ver todo", style: TextStyle(color: kPrimaryColor))),
                      ],
                    ),
                  ),

                  ListView.builder( // Widget: ListView — Uso: Lista vertical de productos populares (shrinkWrap).
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: popularPizzas.length,
                    itemBuilder: (context, index) {
                      final pizza = popularPizzas[index];
                      return GestureDetector( // Widget: GestureDetector — Uso: Navegación hacia `ProductDetailScreen` al tocar una card.
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                title: pizza["title"],
                                price: pizza["price"],
                                imageUrl: pizza["image"],
                              ),
                            ),
                          );
                        },
                        child: _PizzaCard(
                          title: pizza["title"],
                          ingredients: pizza["ingredients"],
                          price: pizza["price"],
                          imageUrl: pizza["image"],
                          rating: pizza["rating"],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PizzaCard extends StatelessWidget {
  final String title;
  final String ingredients;
  final String price;
  final String imageUrl;
  final String rating;

  const _PizzaCard({
    required this.title,
    required this.ingredients,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container( // Widget: Container — Uso: Tarjeta principal de la pizza.
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
          ClipRRect( // Widget: ClipRRect — Uso: Redondea la imagen lateral de la carta.
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.network(
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
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.local_pizza, color: Colors.grey, size: 40),
                    ),
                  );
                },
              ),
            ),
          ),

          Expanded( // Widget: Expanded — Uso: Contenido textual y acciones dentro de la card.
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    ingredients,
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: kTextColor)),
                      Container( // Widget: Container — Uso: Botón circular de 'Agregar' en la card.
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add, color: kWhiteColor, size: 20),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget: Scaffold — Uso: Contenedor principal de la pantalla con `drawer` y `body`.
// Widget: Drawer — Uso: Panel lateral de navegación (Se usa `CustomDrawer`).
// Widget: Column / Row — Uso: Organización de cabecera, listas y tarjetas.
// Widget: Stack — Uso: Superposición en banners y cabeceras.
// Widget: Expanded / Flexible — Uso: Expandir áreas (listas, tarjetas) para usar el espacio disponible.
// Widget: Container — Uso: Paneles gráficos con padding, bordes y sombra.
// Widget: Padding, Center, Align — Uso: Alineación y separación del contenido.
// Widget: SizedBox — Uso: Espaciadores entre elementos.
// Widget: ListView — Uso: Listas horizontales y verticales de categorías y productos.
// Widget: GridView — Uso: (no usado directamente aquí) — ver `DessertsScreen` para grids.
// Widget: ElevatedButton, TextButton, OutlinedButton — Uso: `ElevatedButton` y `TextButton` para acciones como agregar o ver todo.
// Widget: TextField — Uso: Campo de búsqueda en la cabecera.