import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../features/cart/data/models/order_model.dart';
import '../features/cart/presentation/providers/order_provider.dart';

const Color kPrimaryColor = Color(0xFFD32F2F);
const Color kBackgroundColor = Color(0xFFF2F2F2);

class OrderDetailScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false)
          .fetchOrderDetails(widget.order.id);
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
      case 'entregado':
        return Colors.green;
      case 'en proceso':
      case 'preparando':
        return Colors.blue;
      case 'pendiente':
        return Colors.orange;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completado':
      case 'entregado':
        return Icons.check_circle;
      case 'en proceso':
      case 'preparando':
        return Icons.pending;
      case 'pendiente':
        return Icons.access_time;
      case 'cancelado':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy, HH:mm', 'es_ES').format(date);
  }

  Future<void> _refreshDetails() async {
    await Provider.of<OrderProvider>(context, listen: false)
        .fetchOrderDetails(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final order = widget.order;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(order.code, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: kPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 2,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshDetails,
        color: kPrimaryColor,
        child: provider.isLoadingDetails
            ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
            : provider.currentDetails.isEmpty
                ? _buildEmptyState()
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.receipt_long, color: kPrimaryColor, size: 24),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "Resumen del Pedido",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              _InfoRowWithIcon(
                                icon: Icons.calendar_today,
                                label: "Fecha",
                                value: _formatDate(order.date),
                              ),
                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
                                  const SizedBox(width: 12),
                                  Text("Estado", style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(order.status).withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: _getStatusColor(order.status).withOpacity(0.5),
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              _getStatusIcon(order.status),
                                              color: _getStatusColor(order.status),
                                              size: 18,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              order.status.toUpperCase(),
                                              style: TextStyle(
                                                color: _getStatusColor(order.status),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              
                              const Divider(height: 30, thickness: 1),

                              _buildPriceBreakdown(order),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.shopping_bag_outlined, color: kPrimaryColor),
                              const SizedBox(width: 8),
                              Text(
                                "Productos (${provider.currentDetails.length})",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: provider.currentDetails.length,
                          itemBuilder: (context, index) {
                            final item = provider.currentDetails[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.productImage,
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return Container(
                                          width: 70,
                                          height: 70,
                                          color: Colors.grey[200],
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded /
                                                      loadingProgress.expectedTotalBytes!
                                                  : null,
                                              strokeWidth: 2,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (_, __, ___) => Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Icon(Icons.fastfood, color: Colors.grey[400], size: 30),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                "x${item.quantity}",
                                                style: const TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "\$${item.unitPrice.toStringAsFixed(2)} c/u",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "\$${(item.quantity * item.unitPrice).toStringAsFixed(2)}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              if (order.status.toLowerCase() != 'cancelado' &&
                                  order.status.toLowerCase() != 'completado')
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Función de seguimiento en desarrollo'),
                                          backgroundColor: kPrimaryColor,
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.location_on, color: Colors.white),
                                    label: const Text(
                                      'Seguir pedido',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Función en desarrollo')),
                                        );
                                      },
                                      icon: const Icon(Icons.support_agent, size: 20),
                                      label: const Text('Soporte'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: kPrimaryColor,
                                        side: const BorderSide(color: kPrimaryColor),
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Función en desarrollo')),
                                        );
                                      },
                                      icon: const Icon(Icons.refresh, size: 20),
                                      label: const Text('Reordenar'),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: kPrimaryColor,
                                        side: const BorderSide(color: kPrimaryColor),
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildPriceBreakdown(OrderModel order) {
    final subtotal = order.total * 0.93;
    final shipping = order.total * 0.07;

    return Column(
      children: [
        _PriceRow(label: "Subtotal", value: subtotal),
        const SizedBox(height: 8),
        _PriceRow(label: "Envío", value: shipping),
        const Divider(height: 20, thickness: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.payments, color: kPrimaryColor, size: 22),
                SizedBox(width: 8),
                Text(
                  "Total Pagado",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
            Text(
              "\$${order.total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 24,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No hay detalles disponibles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Desliza hacia abajo para actualizar',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRowWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRowWithIcon({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 15)),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final double value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ],
    );
  }
}