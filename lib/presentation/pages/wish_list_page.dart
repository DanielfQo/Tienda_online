import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tienda_online/presentation/providers/auth_provider.dart';
import 'package:tienda_online/presentation/providers/user_provider.dart';
import '../providers/wishlist_provider.dart';
import '../../domain/entities/product.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final wishlistProvider = Provider.of<WishlistProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      final token = authProvider.token;
      final clientId = userProvider.user?.id;

      if (token != null && clientId != null) {
        wishlistProvider.loadWishlist(clientId, token);
        
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishListItems = wishlistProvider.wishlist;
    final isLoading = wishlistProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Deseos'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wishListItems.isEmpty
              ? const Center(child: Text('No hay productos en tu lista de deseos'))
              : ListView.builder(
                  itemCount: wishListItems.length,
                  itemBuilder: (context, index) {
                    final item = wishListItems[index];
                    return ListTile(
                      onTap: () => _viewProductDetails(item),
                      title: Text(item.name),
                      subtitle: Text('\$${item.salePrice.toStringAsFixed(2)}'),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart),
                            tooltip: 'Agregar al carrito',
                            onPressed: () => _addToCart(item),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            tooltip: 'Eliminar',
                            onPressed: () => _removeFromWishlist(item),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  void _viewProductDetails(Product product) {
    // TODO: Implementar navegación a la pantalla de detalles del producto
  }

  void _addToCart(Product product) {
    // TODO: Implementar lógica para agregar al carrito
  }

  void _removeFromWishlist(Product product) {
    // TODO: Implementar lógica para eliminar de la wishlist
  }
}
