import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final String image;
  final bool isLiked;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    this.image = '',
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [

            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Color(0xFFFFE0B2),
                    ),
                    image.isNotEmpty
                      ? Image.network(image, height: 60)
                      : const Icon(Icons.image, size: 60),
                  ],
                ),
                const SizedBox(height: 8),
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text(
                  'Trending Now',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  'S/ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
