import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/cart/presentation/providers/cart_provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../widgets/cart_item.dart';
import 'base_screen.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    Future<void> handleClearCart() async {
      final shouldClear = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text("Vaciar carrito"),
              content: const Text(
                "Esto eliminará todos los productos del carrito. ¿Continuar?",
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text("Cancelar"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: const Text("Vaciar"),
                ),
              ],
            ),
          ) ??
          false;

      if (shouldClear) {
        cart.clearCart();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Carrito vacío"),
            backgroundColor: Colors.black87,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    // Lógica simple de envío
    const double deliveryFee = 2.50;
    final double grandTotal = cart.items.isEmpty ? 0 : cart.totalAmount + deliveryFee;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: cart.items.isEmpty
          ? const _EmptyCartState()
          : Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      
                      // --- CORRECCIÓN AQUÍ ---
                      SliverAppBar(
                        backgroundColor: kPrimaryColor,
                        
                        // 1. Esto deja la barra FIJA arriba
                        pinned: true,  
                        floating: false,
                        snap: false,
                        elevation: 0,
                        centerTitle: true,
                        iconTheme: const IconThemeData(color: Colors.white),

                        // 2. Título FIJO (Sin animación de tamaño)
                        // Al ponerlo aquí directo, ya no se estira ni encoge.
                        title: const Text(
                          "Mi Orden",
                          style: TextStyle(
                            color: Colors.white, 
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        // Quitamos el expandedHeight grande para que sea una barra normal
                        // expandedHeight: 80, // <-- ELIMINADO o reducido
                      ),

                      // Dirección de Entrega + Acción de vaciado (responsivo)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final Widget deliveryCard = Container(
                                constraints: const BoxConstraints(minHeight: 96),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: kPrimaryColor.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.location_on, color: kPrimaryColor),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Entregar en:",
                                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                                          ),
                                          const Text(
                                            "Casa - Calle 123",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Editar",
                                        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              );

                              final bool disableClear = cart.isProcessing || cart.items.isEmpty;

                              final Widget clearButton = Opacity(
                                opacity: disableClear ? 0.4 : 1,
                                child: Material(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(15),
                                  elevation: 3,
                                  shadowColor: kPrimaryColor.withOpacity(0.35),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(15),
                                    onTap: disableClear ? null : handleClearCart,
                                    child: const SizedBox(
                                      height: 96,
                                      width: 96,
                                      child: Center(
                                        child: Icon(
                                          Icons.delete_sweep_outlined,
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: deliveryCard),
                                  const SizedBox(width: 12),
                                  clearButton,
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Lista de Productos
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final item = cart.items[index];
                            return Dismissible(
                              key: Key(item.product.id),
                              direction: DismissDirection.endToStart,
                              onDismissed: (_) => cart.removeProductCompletely(item.product.id),
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 25),
                                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.red[100], 
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: const Icon(Icons.delete_outline, color: kPrimaryColor, size: 30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: CartItem(
                                  title: item.product.name,
                                  price: "\$${item.product.price}",
                                  imageUrl: item.product.imageUrl,
                                  quantity: item.quantity,
                                  onAdd: () => cart.addToCart(item.product),
                                  onRemove: () => cart.removeOneItem(item.product.id),
                                ),
                              ),
                            );
                          },
                          childCount: cart.items.length,
                        ),
                      ),

                      // Cupón
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.withOpacity(0.2)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.confirmation_number_outlined, color: Colors.grey[600]),
                              hintText: "Código de promoción",
                              border: InputBorder.none,
                              suffixIcon: TextButton(
                                onPressed: () {},
                                child: const Text("Aplicar", 
                                  style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold)
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    ],
                  ),
                ),

                // Panel de Pago
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), 
                        blurRadius: 20, 
                        offset: const Offset(0, -5)
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SummaryRow(label: "Subtotal", value: cart.totalAmount),
                      const SizedBox(height: 10),
                      const _SummaryRow(label: "Costo de Envío", value: deliveryFee),
                      const Divider(height: 30),
                      _SummaryRow(label: "Total", value: grandTotal, isTotal: true),
                      
                      const SizedBox(height: 20),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            foregroundColor: Colors.white,
                            elevation: 5,
                            shadowColor: kPrimaryColor.withOpacity(0.4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          
                          onPressed: cart.isProcessing
                            ? null 
                            : () async {
                                if (authProvider.status != AuthStatus.authenticated) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Debes iniciar sesión para pedir 🔒"), 
                                      backgroundColor: Colors.orange
                                    ),
                                  );
                                  return;
                                }

                                final success = await cart.submitOrder(authProvider.currentUser!.id);

                                if (!context.mounted) return;

                                if (success) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const BaseScreen()),
                                    (route) => false,
                                  );
                                  
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("¡Pedido recibido! 👨‍🍳 Cocinando..."), 
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 4),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Error al procesar el pedido ❌"), 
                                      backgroundColor: Colors.red
                                    ),
                                  );
                                }
                              },
                          child: cart.isProcessing
                              ? const SizedBox(
                                  width: 24, 
                                  height: 24, 
                                  child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Confirmar Pedido", 
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                                    ),
                                    SizedBox(width: 10),
                                    Icon(Icons.arrow_forward_rounded, size: 20),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _EmptyCartState extends StatelessWidget {
  const _EmptyCartState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_cart_outlined, size: 60, color: kPrimaryColor),
          ),
          const SizedBox(height: 20),
          const Text("Tu carrito está vacío", 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 10),
          Text("¡Agrega algunas pizzas deliciosas!", 
            style: TextStyle(fontSize: 16, color: Colors.grey[600])
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen()), 
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Ir al Menú", style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double value;
  final bool isTotal;

  const _SummaryRow({required this.label, required this.value, this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label, 
          style: TextStyle(
            fontSize: isTotal ? 18 : 14, 
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? kTextColor : Colors.grey[600]
          )
        ),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 22 : 14,
            fontWeight: isTotal ? FontWeight.w900 : FontWeight.bold,
            color: isTotal ? kPrimaryColor : kTextColor
          ),
        ),
      ],
    );
  }
}