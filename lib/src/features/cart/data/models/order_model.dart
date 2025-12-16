class OrderModel {
  final String id;
  final String code; // 'ORD-1', 'ORD-2'
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

  // Convertir JSON de Supabase a Dart
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      code: json['codigo_orden'] ?? 'Pendiente', // Tu columna generada
      total: (json['precio_total'] as num).toDouble(), // Tu columna de precio
      status: json['estado'] ?? 'recibido',
      date: DateTime.parse(json['fecha']), // Supabase devuelve String ISO8601
    );
  }
}