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

  // 1. De JSON (Supabase) a Dart
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['nombre'] ?? 'Sin nombre', // Mapeamos 'nombre' de la DB a 'name'
      description: json['descripcion'] ?? '',
      // Supabase a veces devuelve int o double, esto asegura que sea double
      price: (json['precio'] as num?)?.toDouble() ?? 0.0,
      rating: (json['calificacion'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imagen_url'] ?? '',
    );
  }

  // 2. De Dart a JSON (Por si quieres subir productos después)
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