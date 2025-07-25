import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
<<<<<<< HEAD
<<<<<<< HEAD

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/product_table_item.dart';
import '../../widgets/admin_app_bar.dart';
=======
>>>>>>> fabricio-2
=======
>>>>>>> 87f143bf63659d35af2020f289ed551a3b53b645

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/product_table_item.dart';
import '../../widgets/admin_app_bar.dart';
import 'package:tienda_online/domain/entities/product.dart';
import '../../../data/datasources/remote/product_service.dart';

import 'package:go_router/go_router.dart';

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/product_table_item.dart';
import '../../widgets/admin_app_bar.dart';

class AdminProductsPage extends StatefulWidget {
  const AdminProductsPage({super.key});

  @override
  State<AdminProductsPage> createState() => _AdminProductsPageState();
}

class _AdminProductsPageState extends State<AdminProductsPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts('AQUI_EL_TOKEN'); // reemplaza luego por tu AuthProvider
  }

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
      appBar: AppBar(
        title: const Text('Gestión de Productos'),
        backgroundColor: Colors.orange,
      ),
<<<<<<< HEAD
      body: Padding(
        padding: const EdgeInsets.all(16),
<<<<<<< HEAD
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
=======
        child: FutureBuilder<List<Product>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay productos'));
            }

            final productos = snapshot.data!;
            return ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];
                return ProductTableItem(
                  id: producto.id,
                  name: producto.name,
                  stock: producto.stock,
                  price: producto.salePrice,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Producto ${producto.name}')),
                    );
                  },
                );
              },
            );
          },
>>>>>>> fabricio-2
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          context.push(AppRoutes.adminProductsCreate);
        },
=======
      body: const Center(
        child: Text('Contenido de administración de productos'),
>>>>>>> 87f143bf63659d35af2020f289ed551a3b53b645
      ),
    );
  }
}
