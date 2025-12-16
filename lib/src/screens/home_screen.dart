import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/product/presentation/providers/product_provider.dart';
import '../features/cart/presentation/providers/cart_provider.dart'; // <--- 1. IMPORTANTE: Agregado
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

    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          // --- HEADER ---
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 25),
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
                      decoration: BoxDecoration(color: kWhiteColor.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.notifications_outlined, color: kWhiteColor),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(15)),
                  child: const TextField(
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
                  // Banner Promocional
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
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
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

                  // Carrusel
                  SizedBox(
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DessertsScreen()));
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
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                                  ),
                                  child: Icon(category["icon"], color: isSelected ? kWhiteColor : kPrimaryColor),
                                ),
                                const SizedBox(height: 8),
                                Text(category["label"], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? kPrimaryColor : Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Más Populares", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kTextColor)),
                        TextButton(onPressed: () {}, child: const Text("Ver todo", style: TextStyle(color: kPrimaryColor))),
                      ],
                    ),
                  ),

                  // CONSUMER DE PRODUCTOS
                  Consumer<ProductProvider>(
                    builder: (context, provider, child) {
                      if (provider.isLoading) {
                        return const Center(child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(color: kPrimaryColor),
                        ));
                      }
                      if (provider.errorMessage != null) {
                        return Center(child: Text(provider.errorMessage!, style: const TextStyle(color: Colors.red)));
                      }
                      if (provider.products.isEmpty) {
                        return const Center(child: Text("No hay pizzas disponibles hoy"));
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.products.length,
                        itemBuilder: (context, index) {
                          final pizza = provider.products[index];
                          
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(product: pizza),
                                ),
                              );
                            },
                            child: _PizzaCard(
                              title: pizza.name,
                              ingredients: pizza.description,
                              price: "\$${pizza.price.toStringAsFixed(2)}",
                              imageUrl: pizza.imageUrl,
                              rating: pizza.rating.toString(),
                              // 2. CONECTAMOS LA LÓGICA DE AGREGAR
                              onAdd: () {
                                Provider.of<CartProvider>(context, listen: false).addToCart(pizza);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("¡\${pizza.name} agregada!"),
                                    duration: const Duration(seconds: 1),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              },
                            ),
                          );
                        },
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

// 3. WIDGET ACTUALIZADO (Recibe onAdd)
class _PizzaCard extends StatelessWidget {
  final String title;
  final String ingredients;
  final String price;
  final String imageUrl;
  final String rating;
  final VoidCallback onAdd; // <--- NUEVO CAMPO

  const _PizzaCard({
    required this.title,
    required this.ingredients,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.onAdd, // <--- REQUERIDO
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Row(
        children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              child: SizedBox(
                width: 120,
                height: 120,
                child: Hero( // <--- AGREGAR ESTO
                  tag: title, // Usamos el título o ID como tag único (debe coincidir con el del detalle)
                  // Nota: Lo ideal es usar product.id, pero en _PizzaCard solo tienes title.
                  // Si puedes, pasa el 'id' a _PizzaCard. Si no, usa 'title' temporalmente.
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    // ...
                  ),
                ),
              ),
            ),
          Expanded(
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
                  Text(ingredients, style: TextStyle(color: Colors.grey[500], fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: kTextColor)),
                      
                      // BOTÓN FUNCIONAL
                      InkWell(
                        onTap: onAdd, // <--- Acción al tocar
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.add, color: kWhiteColor, size: 20),
                        ),
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