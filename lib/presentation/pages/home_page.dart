import 'package:flutter/material.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> allProducts = [
    {"name": "Botella", "price": 7.0, "oferta": true},
    {"name": "Juguete", "price": 5.0, "oferta": true},
    {"name": "Cuaderno", "price": 10.0, "oferta": false},
    {"name": "Lapicero", "price": 2.5, "oferta": false},
    {"name": "Gorra", "price": 15.0, "oferta": false},
    {"name": "Camisa", "price": 25.0, "oferta": false},
  ];

  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offerProducts = allProducts
        .where((p) => p['oferta'] == true)
        .toList();
    final normalProducts = allProducts
        .where((p) => p['oferta'] == false)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thunder",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // 🔍 Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),

          // 🏷️ Slider de ofertas
          if (offerProducts.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Ofertas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.local_offer, size: 18, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Slider tipo PageView
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: offerProducts.length,
                    itemBuilder: (context, index) {
                      final product = offerProducts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ProductCard(
                          name: product['name'],
                          price: product['price'],
                        ),
                      );
                    },
                  ),
                ),

                // Indicador (círculos)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    offerProducts.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 8,
                      ),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white30,
                      ),
                    ),
                  ),
                ),
              ],
            ),

          // 🛍️ Grid de productos normales
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65,
              ),
              itemCount: normalProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: normalProducts[index]['name'],
                  price: normalProducts[index]['price'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
