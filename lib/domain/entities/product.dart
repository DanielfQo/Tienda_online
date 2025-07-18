class Product {
  final int id;
  final String name;
  final String description;
  final String purchasePrice;
  final String salePrice;
  final int stock;
  final DateTime createdAt;
  final List<String> imageUrls;
  final List<String> attributes;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.purchasePrice,
    required this.salePrice,
    required this.stock,
    required this.createdAt,
    required this.imageUrls,
    required this.attributes,
  });
}
