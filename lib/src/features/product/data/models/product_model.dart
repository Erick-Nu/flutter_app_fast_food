import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.rating,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['nombre'] ?? 'Sin nombre',
      description: json['descripcion'] ?? '',
      price: (json['precio'] as num?)?.toDouble() ?? 0.0,
      rating: (json['calificacion'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imagen_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': name,
      'descripcion': description,
      'precio': price,
      'calificacion': rating,
      'imagen_url': imageUrl,
    };
  }
}