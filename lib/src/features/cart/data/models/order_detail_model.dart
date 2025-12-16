class OrderDetailModel {
  final String id;
  final String productName; // Viene de la tabla 'productos'
  final String productImage; // Viene de la tabla 'productos'
  final int quantity;
  final double unitPrice;

  OrderDetailModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.quantity,
    required this.unitPrice,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    // Supabase nos devuelve los datos del producto anidados
    final productData = json['productos'] ?? {}; 
    
    return OrderDetailModel(
      id: json['id'],
      quantity: json['cantidad'],
      unitPrice: (json['precio_unitario'] as num).toDouble(),
      // Extraemos datos del producto relacionado
      productName: productData['nombre'] ?? 'Producto desconocido',
      productImage: productData['imagen_url'] ?? '',
    );
  }
}