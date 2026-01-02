class OrderModel {
  final String id;
  final String code;
  final double total;
  final String status;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.code,
    required this.total,
    required this.status,
    required this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      code: json['codigo_orden'] ?? 'Pendiente',
      total: (json['precio_total'] as num).toDouble(),
      status: json['estado'] ?? 'recibido',
      date: DateTime.parse(json['fecha']),
    );
  }
}