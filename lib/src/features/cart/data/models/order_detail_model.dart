class OrderDetailModel {
  final String id;
  final String productName;
  final String productImage;
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
    final productData = json['productos'] ?? {}; 
    
    return OrderDetailModel(
      id: json['id'],
      quantity: json['cantidad'],
      unitPrice: (json['precio_unitario'] as num).toDouble(),
      productName: productData['nombre'] ?? 'Producto desconocido',
      productImage: productData['imagen_url'] ?? '',
    );
  }
}