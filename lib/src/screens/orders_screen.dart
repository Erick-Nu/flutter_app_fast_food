import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import '../features/cart/presentation/providers/order_provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'order_detail_screen.dart';
import 'base_screen.dart'; 

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);
const Color kTextColor = Color(0xFF333333);

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Método separado para usarlo al iniciar y al deslizar (refresh)
  Future<void> _loadOrders() async {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      await Provider.of<OrderProvider>(context, listen: false).fetchOrders(user.id);
    }
  }

  List<dynamic> _getFilteredOrders(List<dynamic> orders) {
    var filtered = orders.toList();
    // Ordenar por fecha descendente
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  Map<String, dynamic> _getStatistics(List<dynamic> orders) {
    if (orders.isEmpty) return {'total': 0, 'amount': 0.0};

    final now = DateTime.now();
    final thisMonthOrders = orders.where((order) {
      final orderDate = order.date;
      return orderDate.year == now.year && orderDate.month == now.month;
    }).toList();

    final totalAmount = thisMonthOrders.fold<double>(0, (sum, order) => sum + order.total);

    return {
      'total': thisMonthOrders.length,
      'amount': totalAmount,
    };
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text("Mis Pedidos", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Sin notificaciones nuevas'))
              );
            },
          ),
        ],
      ),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : RefreshIndicator(
              onRefresh: _loadOrders,
              color: kPrimaryColor,
              child: Column(
                children: [
                  // Estadísticas
                  if (orderProvider.orders.isNotEmpty) _buildStatisticsCard(orderProvider.orders),

                  // Lista de pedidos o vacío
                  Expanded(
                    child: orderProvider.orders.isEmpty
                        ? const _EmptyOrders()
                        : _buildOrdersList(orderProvider, orderProvider.orders),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const BaseScreen()),
            (route) => false,
          );
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatisticsCard(List<dynamic> orders) {
    final stats = _getStatistics(orders);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [kPrimaryColor.withOpacity(0.9), kPrimaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatisticItem(icon: Icons.shopping_bag, label: 'Este mes', value: '${stats['total']}'),
          Container(
            width: 1,
            height: 40,
            color: Colors.white.withOpacity(0.3),
          ),
          _StatisticItem(
            icon: Icons.attach_money,
            label: 'Gastado',
            value: '\$${(stats['amount'] as double).toStringAsFixed(0)}',
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(OrderProvider provider, List<dynamic> orders) {
    final filteredOrders = _getFilteredOrders(orders);

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay pedidos en esta categoría',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta cambiar el filtro o búsqueda',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(milliseconds: 300 + (index * 100)),
          builder: (context, double value, child) {
            return Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: _OrderCard(order: order),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final dynamic order; 
  const _OrderCard({required this.order});

  // Colores según estado
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'entregado': return Colors.green[700]!;
      case 'en_camino': return Colors.orange[800]!;
      case 'preparando': return Colors.blue[700]!;
      case 'recibido': return Colors.purple[600]!;
      default: return Colors.grey;
    }
  }

  // Icono según estado
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'entregado': return Icons.check_circle;
      case 'en_camino': return Icons.local_shipping;
      case 'preparando': return Icons.restaurant;
      case 'recibido': return Icons.receipt_long;
      default: return Icons.info_outline;
    }
  }

  // Texto legible
  String _getStatusText(String status) {
    final clean = status.replaceAll('_', ' ');
    return clean.substring(0, 1).toUpperCase() + clean.substring(1);
  }

  // Tiempo relativo
  String _getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'Hace unos momentos';
    if (difference.inMinutes < 60) return 'Hace ${difference.inMinutes}m';
    if (difference.inHours < 24) return 'Hace ${difference.inHours}h';
    if (difference.inDays < 7) return 'Hace ${difference.inDays}d';
    
    return DateFormat('dd MMM', 'es').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusIcon = _getStatusIcon(order.status);
    final relativeTime = _getRelativeTime(order.date);
    final isActive = order.status.toLowerCase() != 'entregado';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isActive
            ? Border.all(color: kPrimaryColor.withOpacity(0.3), width: 1.5)
            : null,
        boxShadow: [
          BoxShadow(
            color: isActive ? kPrimaryColor.withOpacity(0.15) : Colors.black.withOpacity(0.05),
            blurRadius: isActive ? 12 : 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailScreen(order: order),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                // 1. FILA SUPERIOR: Código y Estado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.code,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: kTextColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            relativeTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: statusColor.withOpacity(0.5),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: statusColor, size: 16),
                          const SizedBox(width: 6),
                          Text(
                            _getStatusText(order.status),
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Divider(height: 18, thickness: 0.8),

                // 2. FILA INFERIOR: Total y flecha
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                        const SizedBox(height: 4),
                        Text(
                          "\$${order.total.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Ver detalles",
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: kPrimaryColor),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatisticItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                size: 70,
                color: kPrimaryColor.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "No tienes pedidos aún",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "¡Pide tu primera pizza hoy!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const BaseScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.shopping_bag, color: Colors.white),
              label: const Text("Ir al Menú"),
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}