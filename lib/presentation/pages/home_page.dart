import 'package:flutter/material.dart';
import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> allProducts = List.generate(
    10,
    (i) => {
      'name': 'Producto ${i + 1}',
      'price': (i + 1) * 10.0,
      'image': 'assets/images/shoe.png', // reemplaza con tus imágenes
      'oferta': i % 2 == 0,
      'isliked': false,
    },
  );

  @override
  Widget build(BuildContext context) {
    final ofertas = allProducts.where((p) => p['oferta'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColor.background,
        elevation: 0,
        title: const Text(
          "Thunder",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: AppTheme.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Buscador
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: LightColor.lightGrey.withAlpha(100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Buscar productos',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.black54),
                        contentPadding: EdgeInsets.only(top: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 🏷️ Categorías (falsas por ahora)
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryIcon(
                    'assets/icons/sneakers.png',
                    'Sneakers',
                    true,
                  ),
                  _buildCategoryIcon(
                    'assets/icons/jacket.png',
                    'Jacket',
                    false,
                  ),
                  _buildCategoryIcon('assets/icons/watch.png', 'Watch', false),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 🔄 Slider de productos en oferta
            if (ofertas.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ofertas",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.7),
                      itemCount: ofertas.length,
                      itemBuilder: (context, index) {
                        final p = ofertas[index];
                        return ProductCard(
                          name: p['name'],
                          price: p['price'],
                          image: p['image'],
                          isLiked: p['isliked'],
                        );
                      },
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            // 🛍️ Grid de productos
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allProducts.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final p = allProducts[index];
                return ProductCard(
                  name: p['name'],
                  price: p['price'],
                  image: p['image'],
                  isLiked: p['isliked'],
                );
              },
            ),
          ],
        ),
      ),

      // 🔽 Barra inferior
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }

  Widget _buildCategoryIcon(String asset, String label, bool selected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: selected ? LightColor.orange : LightColor.grey,
        ),
        borderRadius: BorderRadius.circular(12),
        color: selected ? LightColor.background : Colors.transparent,
      ),
      child: Row(
        children: [
          Image.asset(asset, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
