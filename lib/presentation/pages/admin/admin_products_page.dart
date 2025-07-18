import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/product_table_item.dart';
import '../../widgets/admin_app_bar.dart';

class AdminProductsPage extends StatelessWidget {
  const AdminProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> productos = List.generate(
      20,
      (index) => {
        'id': index + 1,
        'nombre': 'Producto ${index + 1}',
        'stock': (index + 1) * 5,
        'precio': (index + 1) * 10.0,
      },
    );

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      appBar: const AdminAppBar(
        title: 'Productos',
        returnRoute: AppRoutes.homeAdmin,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  return ProductTableItem(
                    id: producto['id'],
                    name: producto['nombre'],
                    stock: producto['stock'],
                    price: producto['precio'],
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Producto ${producto['nombre']}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppRoutes.adminProductsCreate);
        },
      ),
    );
  }
}
