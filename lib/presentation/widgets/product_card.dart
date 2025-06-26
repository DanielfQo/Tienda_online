import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final double price;

  const ProductCard({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Imagen del producto
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
              child: const Icon(Icons.image, size: 60, color: Colors.white54),
            ),
          ),
          // Precio y botón
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'S/ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD86A), // amarillo suave
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 2,
                  ),
                  child: const Text('Agregar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
