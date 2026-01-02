import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../features/cart/presentation/providers/order_provider.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import 'order_detail_screen.dart';
import 'base_screen.dart';

// --- COLORES & ESTILOS ---
const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF8F9FA); 
const Color kTextColor = Color(0xFF2D3436);

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Estado para los filtros de la lista visual
  String _selectedFilter = 'Todos';
  final List<String> _filters = ['Todos', 'En Curso', 'Entregados'];

  @override
  void initState() {
    super.initState();
    // Carga inicial de datos
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadOrders());
  }

  Future<void> _loadOrders() async {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      await Provider.of<OrderProvider>(context, listen: false).fetchOrders(user.id);
    }
  }

  // Lógica de Filtrado para la LISTA (visualización)
  List<dynamic> _getFilteredOrders(List<dynamic> orders) {
    var filtered = orders.toList();
    
    // 1. Aplicar Filtro
    if (_selectedFilter == 'En Curso') {
      filtered = filtered.where((o) => o.status.toLowerCase() != 'entregado' && o.status.toLowerCase() != 'cancelado').toList();
    } else if (_selectedFilter == 'Entregados') {
      filtered = filtered.where((o) => o.status.toLowerCase() == 'entregado').toList();
    }

    // 2. Ordenar por fecha (más reciente primero)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  // --- MODIFICACIÓN AQUÍ: Estadísticas Totales ---
  Map<String, dynamic> _getStatistics(List<dynamic> orders) {
    if (orders.isEmpty) return {'total': 0, 'amount': 0.0};
    
    // Ahora sumamos TODOS los pedidos de la lista, sin filtrar por mes.
    final totalAmount = orders.fold<double>(0.0, (sum, order) => sum + (order.total as num).toDouble());
    
    return {
      'total': orders.length, 
      'amount': totalAmount
    };
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos al provider para que se actualice automáticamente
    final orderProvider = Provider.of<OrderProvider>(context);
    final filteredOrders = _getFilteredOrders(orderProvider.orders);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Mis Pedidos", 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: RefreshIndicator(
        onRefresh: _loadOrders,
        color: kPrimaryColor,
        child: Column(
          children: [
            // Header Curvo Rojo
            Stack(
              children: [
                Container(
                  height: 30,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.zero),
                  ),
                ),
              ],
            ),

            // 1. TARJETA DE RESUMEN (ESTADÍSTICAS ACTUALIZADAS)
            if (orderProvider.orders.isNotEmpty) 
              Transform.translate(
                offset: const Offset(0, -20), 
                child: _buildSummaryCard(orderProvider.orders),
              ),

            // 2. BARRA DE FILTROS
            if (orderProvider.orders.isNotEmpty)
              Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = _selectedFilter == filter;
                    return ChoiceChip(
                      label: Text(filter),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() => _selectedFilter = filter);
                      },
                      selectedColor: kPrimaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : kTextColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: isSelected ? Colors.transparent : Colors.grey.shade300)
                      ),
                    );
                  },
                ),
              ),

            // 3. LISTA DE PEDIDOS
            Expanded(
              child: orderProvider.isLoading 
                ? const _LoadingSkeleton()
                : filteredOrders.isEmpty
                    ? const _EmptyStateFiltered()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredOrders.length,
                        itemBuilder: (context, index) {
                          final order = filteredOrders[index];
                          return _OrderCardModern(order: order);
                        },
                      ),
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
        backgroundColor: Colors.black,
        elevation: 4,
        child: const Icon(Icons.add_shopping_cart, color: Colors.white),
      ),
    );
  }

  // Tarjeta de Resumen Cuadrada con Datos Totales
  Widget _buildSummaryCard(List<dynamic> orders) {
    final stats = _getStatistics(orders); // Calcula suma total
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(10), // Esquinas cuadradas
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.1),
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.attach_money, color: kPrimaryColor, size: 24),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Etiqueta actualizada para reflejar "todos los gastos"
                  Text("Total Gastado", style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.bold)),
                  Text("\$${(stats['amount'] as double).toStringAsFixed(2)}", style: const TextStyle(color: kTextColor, fontSize: 24, fontWeight: FontWeight.w900)),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                Text("${stats['total']}", style: const TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Pedidos", style: TextStyle(color: Colors.grey[600], fontSize: 10)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// --- WIDGETS AUXILIARES ---

class _OrderCardModern extends StatelessWidget {
  final dynamic order;
  const _OrderCardModern({required this.order});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'entregado': return Colors.green;
      case 'en_camino': return Colors.orange;
      case 'preparando': return Colors.blue;
      case 'cancelado': return Colors.red;
      default: return Colors.purple;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM, h:mm a', 'es').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusText = order.status.replaceAll('_', ' ').toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 5))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order))),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
                          child: const Icon(Icons.receipt, size: 18, color: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order.code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(_formatDate(order.date), style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        statusText,
                        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1),
                ),

                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total", style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text("\$${order.total.toStringAsFixed(2)}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
                      ],
                    ),
                    
                    const Row(
                      children: [
                        Text("Detalles", style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold, fontSize: 12)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 10, color: kPrimaryColor),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (_, __) => Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: CircularProgressIndicator(color: Colors.grey[200])), 
      ),
    );
  }
}

class _EmptyStateFiltered extends StatelessWidget {
  const _EmptyStateFiltered();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.filter_list_off, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 10),
          Text("No hay pedidos con este filtro", style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }
}