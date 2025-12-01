import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necesario para el estilo de la barra de estado
import '../widgets/cart_item.dart';

// --- COLORES DE LA MARCA ---
const Color kPrimaryColor = Color(0xFFD32F2F); // Rojo Pizzería
const Color kBackgroundColor = Color(0xFFF2F2F2); // Gris Fondo
const Color kTextColor = Color(0xFF333333);
const Color kWhiteColor = Colors.white;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // Usamos Column para separar el área de scroll del panel fijo inferior
      body: Column(
        children: [
          // 1. ÁREA DE SCROLL (AppBar + Lista)
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // --- TU NUEVO SLIVER APPBAR ---
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  expandedHeight: 100.0, // Altura compacta pero elegante
                  floating: false,
                  pinned: true,
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                  
                  // Título Flexible
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.only(bottom: 16),
                    title: const Text(
                      'Mi Carrito', // Cambié "Mis Pedidos" por "Mi Carrito"
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  
                  // Bordes Redondeados Inferiores
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
                  ),
                ),

                // --- HEADER DE ENTREGA (Adaptado a Sliver) ---
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.location_on, color: kPrimaryColor, size: 20),
                        ),
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Entregar en',
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              Text(
                                'Casa - Av. Principal 123',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Cambiar', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                  ),
                ),

                // --- LISTA DE PRODUCTOS (SliverList) ---
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Item 1 (Con Dismissible)
                      Dismissible(
                        key: const Key('item1'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.delete_outline, color: kPrimaryColor, size: 30),
                        ),
                        child: const CartItem(
                          title: "Hamburguesa Monster",
                          price: "\$8.50",
                          imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop",
                          quantity: 2,
                        ),
                      ),
                      
                      // Item 2
                      const CartItem(
                        title: "Papas Supreme",
                        price: "\$4.50",
                        imageUrl: "https://images.unsplash.com/photo-1630384031162-91847a68521e?q=80&w=200&auto=format&fit=crop",
                        quantity: 1,
                      ),

                      // Sección de Cupón
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: kWhiteColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.confirmation_number_outlined, color: Colors.green),
                            const SizedBox(width: 12),
                            const Text("Aplicar Cupón", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor)),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
                          ],
                        ),
                      ),
                      
                      // Espacio al final de la lista para que no choque con el panel
                      const SizedBox(height: 20),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          // 2. PANEL DE PAGO FLOTANTE (Fijo abajo)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal", style: TextStyle(color: Colors.grey[600])),
                      const Text("\$13.00", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Envío", style: TextStyle(color: Colors.grey[600])),
                      const Text("\$2.50", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Divider(color: Colors.grey[200]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextColor)),
                      const Text(
                        "\$15.50", 
                        style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.w900, 
                          color: kPrimaryColor
                        )
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Botón de Pago
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: kPrimaryColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ir a Pagar",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 22),
                        ],
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