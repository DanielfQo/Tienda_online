import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import '../../../core/theme/light_color.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/admin_app_bar.dart';
import '../../../data/api_endpoints.dart';

class AdminProductCreatePage extends StatefulWidget {
  const AdminProductCreatePage({super.key});

  @override
  State<AdminProductCreatePage> createState() => _AdminProductCreatePageState();
}

class _AdminProductCreatePageState extends State<AdminProductCreatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();
  final TextEditingController storeIdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final String jwtToken = 'TU_TOKEN_JWT_AQUI';

  Future<bool> createProduct({
    required String token,
    required String name,
    required String description,
    required double purchasePrice,
    required double salePrice,
    required int stock,
    required int categoryId,
    required int storeId,
  }) async {
    final url = Uri.parse(ApiEndpoints.products);

    final body = jsonEncode({
      "name": name,
      "description": description,
      "purchase_price": purchasePrice,
      "sale_price": salePrice,
      "stock": stock,
      "category_id": categoryId,
      "store_id": storeId,
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Error al crear producto: ${response.statusCode} - ${response.body}');
      return false;
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final success = await createProduct(
        token: jwtToken,
        name: nameController.text,
        description: descriptionController.text,
        purchasePrice: double.parse(purchasePriceController.text),
        salePrice: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        categoryId: int.parse(categoryIdController.text),
        storeId: int.parse(storeIdController.text),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto creado correctamente')),
        );
        context.go(AppRoutes.adminProducts);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear el producto')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      appBar: const AdminAppBar(
        title: 'Nuevo Producto',
        returnRoute: AppRoutes.adminProducts,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: nameController,
                label: 'Nombre del producto',
                icon: Icons.shopping_bag,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                label: 'Descripción',
                icon: Icons.description,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese una descripción' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: stockController,
                label: 'Stock',
                icon: Icons.confirmation_number,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese el stock' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: purchasePriceController,
                label: 'Precio de compra',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese el precio de compra' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: priceController,
                label: 'Precio de venta',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese el precio de venta' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: categoryIdController,
                label: 'ID Categoría',
                icon: Icons.category,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese la categoría' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: storeIdController,
                label: 'ID Tienda',
                icon: Icons.store,
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? 'Ingrese la tienda' : null,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Guardar producto',
                onPressed: _submit,
                icon: Icons.save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

