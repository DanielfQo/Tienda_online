import 'package:flutter/material.dart';
import 'product_card.dart';

class OfferSlider extends StatelessWidget {
  final List<Map<String, dynamic>> offers;

  const OfferSlider({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Título de sección
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Ofertas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_forward_ios_rounded, size: 16),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: PageView.builder(
            controller: PageController(viewportFraction: 0.8),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final item = offers[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ProductCard(
                  name: item['name'],
                  price: item['price'],
                  isLiked: true,
                  image: item['image'], // 👈 CAMBIADO AQUÍ
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
