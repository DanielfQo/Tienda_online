import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(image, height: 250, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('\$${price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 16),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                    label: const Text(
                      "Añadir al carrito",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.favorite_border), //whishlist
                  onPressed: () {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
