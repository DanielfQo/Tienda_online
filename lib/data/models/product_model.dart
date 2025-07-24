import 'package:tienda_online/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.purchasePrice,
    required super.salePrice,
    required super.stock,
    required super.createdAt,
    required super.imageUrls,
    required super.attributes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      purchasePrice: (json['purchase_price'] is int)
          ? (json['purchase_price'] as int).toDouble()
          : double.tryParse(json['purchase_price'].toString()) ?? 0.0,
      salePrice: (json['sale_price'] is int)
          ? (json['sale_price'] as int).toDouble()
          : double.tryParse(json['sale_price'].toString()) ?? 0.0,
      stock: json['stock'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      imageUrls:
          (json['images'] as List<dynamic>?)
              ?.map((img) => img['url'] as String)
              .toList() ??
          [],
      attributes:
          (json['values'] as List<dynamic>?)
              ?.map((val) => val['value']?.toString() ?? '')
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'purchase_price': purchasePrice,
    'sale_price': salePrice,
    'stock': stock,
    'created_at': createdAt.toIso8601String(),
    'images': imageUrls.map((url) => {'url': url}).toList(),
    'values': attributes.map((attr) => {'value': attr}).toList(),
  };
}
