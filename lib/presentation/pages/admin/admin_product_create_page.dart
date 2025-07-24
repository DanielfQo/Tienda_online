import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/light_color.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/admin_app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminProductCreatePage extends StatefulWidget {
  const AdminProductCreatePage({super.key});

  @override
  State<AdminProductCreatePage> createState() => _AdminProductCreatePageState();
}

class _AdminProductCreatePageState extends State<AdminProductCreatePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('http://TU_API_URL/api/products/');
      final body = {
        "name": nameController.text,
        "stock": int.parse(stockController.text),
        "sale_price": double.parse(priceController.text),
        "purchase_price": double.parse(priceController.text),
        "category_id": 1,
        "store_id": 1,
        "description": "",
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer TU_TOKEN_JWT",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto creado correctamente')),
        );
        context.go(AppRoutes.adminProducts);
      } else {
        final error = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${error['msg'] ?? 'No se pudo crear'}'),
          ),
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
                controller: stockController,
                label: 'Stock',
                icon: Icons.confirmation_number,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el stock' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: priceController,
                label: 'Precio',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Ingrese el precio' : null,
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
