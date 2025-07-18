import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<Map<String, dynamic>> wishListItems = [
    {'name': 'Producto A', 'price': 25.0, 'category': 'Sneakers'},
    {'name': 'Producto B', 'price': 30.0, 'category': 'Watch'},
    {'name': 'Producto C', 'price': 18.5, 'category': 'Sneakers'},
    {'name': 'Producto D', 'price': 55.0, 'category': 'Jacket'},
  ];

  String? selectedCategory; //null ==== mostrar todos

  void _addToCart(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${wishListItems[index]["name"]} añadido al carrito')),
    );
  }

  void _removeFromWishlist(int index) {
    setState(() {
      wishListItems.removeAt(index);
    });
  }

  void _viewProductDetails(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Detalles de ${product["name"]}')),
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['Todos', 'Sneakers', 'Jacket', 'Watch'];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = (selectedCategory == null && cat == 'Todos') ||
          (selectedCategory == cat);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = (cat == 'Todos') ? null : cat;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  cat,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = selectedCategory == null
    ? wishListItems
    : wishListItems
    .where((item) => item['category'] == selectedCategory)
    .toList();

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          _buildCategorySelector(),
          const Divider(),
          Expanded(
            child: filteredItems.isEmpty
            ? const Center(child: Text("No hay productos en esta categoría."))
            : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  onTap: () => _viewProductDetails(item),
                  title: Text(item['name']),
                  subtitle: Text('\$${item['price']}'),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        tooltip: 'Agregar al carrito',
                        onPressed: () => _addToCart(index),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Eliminar',
                        onPressed: () => _removeFromWishlist(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
    );
  }
}


