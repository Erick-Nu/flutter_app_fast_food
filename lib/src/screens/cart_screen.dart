import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/cart_item.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);
const Color kWhiteColor = Colors.white;

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Widget: Scaffold — Uso: Estructura principal con área de scroll y panel fijo.
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              // Widget: CustomScrollView — Uso: Contenedor que usa Slivers para la lista del carrito.
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar( // Widget: SliverAppBar — Uso: Cabecera flexible dentro del CustomScrollView.
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  expandedHeight: 100.0,
                  floating: false,
                  pinned: true,
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: EdgeInsets.only(bottom: 16),
                    title: Text('Mi Carrito', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
                ),

                SliverToBoxAdapter( // Widget: SliverToBoxAdapter — Uso: Encabezado de dirección / entrega.
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(15), boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))
                    ]),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: kPrimaryColor.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.location_on, color: kPrimaryColor, size: 20)), // Widget: Container + Icon — Uso: Icono de ubicación en el encabezado.
                        const SizedBox(width: 15),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Entregar en', style: TextStyle(fontSize: 12, color: Colors.grey)),
                              Text('Casa - Av. Principal 123', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: kTextColor), maxLines: 1, overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text('Cambiar', style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold))) // Widget: TextButton — Uso: Acción para cambiar dirección.
                      ],
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      Dismissible( // Widget: Dismissible — Uso: Permite eliminar items deslizando.
                        key: const Key('item1'),
                        direction: DismissDirection.endToStart,
                        background: Container(alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: Colors.red[100], borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.delete_outline, color: kPrimaryColor, size: 30)),
                        child: const CartItem(title: "Hamburguesa Monster", price: "\$8.50", imageUrl: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=200&auto=format&fit=crop", quantity: 2), // Widget: CartItem — Uso: Componente que muestra imagen, nombre, precio y controles de cantidad.
                      ),

                      const CartItem(title: "Papas Supreme", price: "\$4.50", imageUrl: "https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=500&auto=format&fit=crop", quantity: 1), // Widget: CartItem — Uso: Item adicional en la lista del carrito.

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),
                        child: Row(children: [const Icon(Icons.confirmation_number_outlined, color: Colors.green), const SizedBox(width: 12), const Text("Aplicar Cupón", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor)), const Spacer(), Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400])]),
                      ),

                      const SizedBox(height: 20),
                    ]),
                  ),
                ),
              ],
            ),
          ),

          Container( // Widget: Container — Uso: Panel fijo inferior que muestra subtotal, envío y botón de pago.
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(color: kWhiteColor, borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5))
            ]),
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Subtotal", style: TextStyle(color: Colors.grey[600])), const Text("\$13.00", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor))]),
                  const SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Envío", style: TextStyle(color: Colors.grey[600])), const Text("\$2.50", style: TextStyle(fontWeight: FontWeight.w600, color: kTextColor))]),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 15), child: Divider(color: Colors.grey[200])),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kTextColor)), const Text("\$15.50", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: kPrimaryColor))]),
                  const SizedBox(height: 20),

                  SizedBox( // Widget: SizedBox + ElevatedButton — Uso: Botón de pago completo que ocupa todo el ancho.
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white, elevation: 8, shadowColor: kPrimaryColor.withValues(alpha: 0.4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("Ir a Pagar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 22)]),
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

// Widget: Scaffold — Uso: Estructura principal con área de scroll y panel fijo.
// Widget: AppBar (SliverAppBar) — Uso: Cabecera flexible dentro del CustomScrollView.
// Widget: Column / Row — Uso: Organización de la pantalla y del panel de pago.
// Widget: Expanded / Flexible — Uso: Area de scroll (lista) ocupa el espacio restante.
// Widget: Container — Uso: Paneles circulares y secciones como header y cupón.
// Widget: Padding, Center, Align — Uso: Separación y alineación dentro de items.
// Widget: SizedBox — Uso: Espaciadores entre elementos.
// Widget: ElevatedButton, TextButton — Uso: Botón de pago y acciones como 'Cambiar'.