import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_online/presentation/providers/auth_provider.dart';
import 'package:tienda_online/presentation/providers/user_provider.dart';
import 'package:tienda_online/presentation/providers/wishlist_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  final String name;
  final double price;
  final List<String> images;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.productId,
    required this.name,
    required this.price,
    required this.images,
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
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
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
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
                    final authProvider = Provider.of<AuthProvider>(context, listen: false);
                    final userProvider = Provider.of<UserProvider>(context, listen: false);

                    final token = authProvider.token;
                    final clientId = userProvider.user?.id;

                    if (token != null && clientId != null) {
                      wishlistProvider.addToWishlist(productId, clientId, token);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Producto añadido a la lista de deseos')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Debes iniciar sesión')),
                      );
                    }
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
