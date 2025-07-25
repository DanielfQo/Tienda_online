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
    super.oferta = false,
    super.isLiked = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      purchasePrice: (json['purchase_price'] is int)
      ? (json['purchase_price'] as int).toDouble()
      : double.parse(json['purchase_price'].toString()),
      salePrice: (json['sale_price'] is int)
      ? (json['sale_price'] as int).toDouble()
      : double.parse(json['sale_price'].toString()),
      stock: json['stock'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      imageUrls: List<String>.from(
        (json['images'] as List<dynamic>).map((img) => img['url'] as String),
      ),
      attributes: List<String>.from(
        (json['values'] as List<dynamic>).map(
          (val) => val['value']?.toString() ?? '',
        ),
      ),
      oferta: json['oferta'] ?? false,
      isLiked: json['isLiked'] ?? false,
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
    'oferta': oferta,
    'isLiked': isLiked,
  };

  Product toEntity() => Product(
    id: id,
    name: name,
    description: description,
    salePrice: salePrice,
    purchasePrice: purchasePrice,
    stock: stock,
    imageUrls: imageUrls,
    createdAt: createdAt,
    attributes: attributes,
    oferta: oferta,
    isLiked: isLiked,
  );

  static ProductModel fromEntity(Product entity) => ProductModel(
    id: entity.id,
    name: entity.name,
    description: entity.description,
    salePrice: entity.salePrice,
    purchasePrice: entity.purchasePrice,
    stock: entity.stock,
    createdAt: entity.createdAt,
    imageUrls: entity.imageUrls,
    attributes: entity.attributes,
    oferta: entity.oferta,
    isLiked: entity.isLiked,
  );
}

