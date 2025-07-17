import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  List<Map<String, dynamic>> wishListItems = [
    {'name': 'Producto A', 'price': 25.0},
    {'name': 'Producto B', 'price': 30.0},
    {'name': 'Producto C', 'price': 18.5},
  ];

  void _removeFromWishlist(int index) {
    setState(() {
      wishListItems.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto eliminado de la lista de deseos')),
    );
  }

  void _addToCart(int index) {
    final item = wishListItems[index];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} añadido al carrito')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de deseos"),
        centerTitle: true,
      ),
      body: wishListItems.isEmpty
      ? const Center(
        child: Text("No hay productos en tu lista de deseos."),
      )
      : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: wishListItems.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = wishListItems[index];
          return ListTile(
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
                  tooltip: 'Eliminar de la lista',
                  onPressed: () => _removeFromWishlist(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
