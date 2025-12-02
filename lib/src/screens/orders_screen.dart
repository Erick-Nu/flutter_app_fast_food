import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

    return Scaffold( // Widget: Scaffold — Uso: Estructura principal que contiene un CustomScrollView con Slivers.
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        // Widget: CustomScrollView — Uso: Contenedor con slivers para listas desplazables.
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar( // Widget: SliverAppBar — Uso: Barra superior con título y comportamiento flexible.
            systemOverlayStyle: SystemUiOverlayStyle.light,
            expandedHeight: 100.0,
            floating: false,
            pinned: true,
            backgroundColor: kPrimaryColor,
            elevation: 0,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 16),
              title: Text(
                'Mis Pedidos',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
            ),
          ),

          SliverPadding( // Widget: SliverPadding + SliverList — Uso: Lista de pedidos en formato sliver.
            padding: const EdgeInsets.all(20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _OrderCard(order: orders[index]);
                },
                childCount: orders.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container( // Widget: Container — Uso: Tarjeta decorativa para cada pedido.
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          Padding( // Widget: Padding — Uso: Espaciado interno alrededor del contenido de la tarjeta.
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect( // Widget: ClipRRect — Uso: Redondea la imagen de miniatura del pedido.
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    order["imageUrl"],
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 70, height: 70, color: Colors.grey[100],
                        child: const Center(child: Icon(Icons.image, size: 20, color: Colors.grey)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70, height: 70, color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 20, color: Colors.grey),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 15),

                Expanded( // Widget: Expanded — Uso: Hace que la columna de texto ocupe el espacio disponible.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order["id"],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kTextColor),
                          ),
                          Text(
                            order["date"],
                            style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
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
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey[100]),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    Text(
                      order["total"],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor.withValues(alpha: 0.08),
                      foregroundColor: kPrimaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text("Repetir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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

// Widget: Scaffold — Uso: Estructura principal que contiene un CustomScrollView con Slivers.
// Widget: AppBar (SliverAppBar) — Uso: Barra superior con título y comportamiento flexible.
// Widget: Column / Row — Uso: Organización vertical y horizontal dentro de las tarjetas.
// Widget: Container — Uso: Contenedores decorativos para cada tarjeta de pedido.
// Widget: Padding — Uso: Separación interna alrededor de elementos en la tarjeta.
// Widget: SizedBox — Uso: Espacios fijos entre elementos.