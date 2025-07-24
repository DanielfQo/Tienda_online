class Product {
  final int id;
  final String name;
  final String description;
  final double purchasePrice;
  final double salePrice;
  final int stock;
  final DateTime createdAt;
  final List<String> imageUrls;
  final List<String> attributes;
  final bool oferta;    // TODO: verificar bd
  bool isLiked;         //

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
    this.oferta = false,
    this.isLiked = false,
  });
}
