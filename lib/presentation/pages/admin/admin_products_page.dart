import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      body: const Center(
        child: Text('Contenido de administración de productos'),
      ),
    );
  }
}
