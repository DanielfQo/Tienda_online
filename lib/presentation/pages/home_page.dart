import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/light_color.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/product_card.dart';
import '../../routes/app_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:tienda_online/presentation/pages/product_detail_page.dart';

import '../providers/products_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.directions_walk, 'label': 'Sneakers'},
    {'icon': Icons.checkroom, 'label': 'Jacket'},
    {'icon': Icons.watch, 'label': 'Watch'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductsProvider>(context, listen: false).loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    if (productsProvider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (productsProvider.error != null) {
      return Scaffold(
        body: Center(child: Text('Error: ${productsProvider.error}')),
      );
    }

    final allProducts = productsProvider.products;
    final ofertas = allProducts.where((p) => p.oferta).toList();

    return SafeArea(
        child: SingleChildScrollView(
          padding: AppTheme.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Buscador
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
                    onPressed: () {
                      // Accion filtro aquí si quieres
                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Categorias horizontales
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final selected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                        // Aquí podrías filtrar productos según categoría
                      },
                      child: _buildCategoryIcon(
                        category['icon'],
                        category['label'],
                        selected,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Ofertas
              if (ofertas.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ofertas",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 250,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.7),
                        itemCount: ofertas.length,
                        itemBuilder: (context, index) {
                          final p = ofertas[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailPage(
                                    name: p.name,
                                    price: p.salePrice,
                                    images: p.imageUrls,
                                    description: p.description,
                                  ),
                                ),
                              );
                            },
                            child: ProductCard(
                              name: p.name,
                              price: p.salePrice,
                              image: p.imageUrls[0],
                              isLiked: p.isLiked,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              // Grid de productos
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(
                            name: p.name,
                            price: p.salePrice,
                            images: p.imageUrls,
                            description: p.description,
                          ),
                        ),
                      );
                    },
                    child: ProductCard(
                      name: p.name,
                      price: p.salePrice,
                      image: p.imageUrls[0],
                      isLiked: p.isLiked,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String label, bool selected) {
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
          Icon(icon, size: 24, color: selected ? LightColor.orange : Colors.black),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
