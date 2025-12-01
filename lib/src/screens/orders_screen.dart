import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos simulados enriquecidos con imágenes
    final List<Map<String, dynamic>> orders = [
      {
        "id": "#ORD-2045",
        "date": "Hoy, 12:30 PM",
        "total": "\$18.50",
        "status": "En Camino",
        "items": "2x Hamburguesa Monster...",
        "statusColor": Colors.orange,
        "imageUrl": "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=150&q=60",
      },
      {
        "id": "#ORD-1982",
        "date": "24 Oct, 8:15 PM",
        "total": "\$45.00",
        "status": "Entregado",
        "items": "4x Pizza Familiar, 2x Papas",
        "statusColor": Colors.green,
        "imageUrl": "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=150&q=60",
      },
      {
        "id": "#ORD-1750",
        "date": "20 Oct, 1:45 PM",
        "total": "\$12.00",
        "status": "Cancelado",
        "items": "1x Ensalada Cesar, 1x Agua",
        "statusColor": Colors.red,
        "imageUrl": "https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=150&q=60",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Mismo fondo que el Carrito
      appBar: AppBar(
        title: const Text(
          'Mis Pedidos',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final order = orders[index];
          return _OrderCard(order: order);
        },
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Sombra suave estilo "Premium" (Igual que en CartScreen y Profile)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // 1. CABECERA DE LA TARJETA (Padding interno)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del producto principal (ClipRRect como en CartItem)
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    order["imageUrl"],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                
                const SizedBox(width: 15),
                
                // Información Central
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order["id"],
                            style: const TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold,
                              color: Colors.black87
                            ),
                          ),
                          Text(
                            order["date"],
                            style: TextStyle(
                              fontSize: 12, 
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        order["items"],
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      // Chip de Estado (Estilo Píldora como en Perfil)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (order["statusColor"] as Color).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          order["status"],
                          style: TextStyle(
                            color: order["statusColor"],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Línea divisoria sutil
          Divider(height: 1, color: Colors.grey[100]),

          // 2. PIE DE TARJETA (Acciones y Total)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Total destacado
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      order["total"],
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.w900,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),

                // Botón "Repetir Pedido" (Estilo Outlined moderno)
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple.withValues(alpha: 0.05),
                      foregroundColor: Colors.deepPurple,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text(
                      "Repetir",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}