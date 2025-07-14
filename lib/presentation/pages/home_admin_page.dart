import 'package:flutter/material.dart';
import '../../core/theme/light_color.dart';
import '../widgets/custom_button.dart';
import '../widgets/admin_category_button.dart';
import '../widgets/resumen_card.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  final List<Map<String, dynamic>> categorias = const [
    {'icon': Icons.people, 'label': 'Usuarios'},
    {'icon': Icons.inventory, 'label': 'Productos'},
    {'icon': Icons.bar_chart, 'label': 'Ventas'},
    {'icon': Icons.handshake, 'label': 'Préstamos'},
    {'icon': Icons.money_off, 'label': 'Gastos'},
    {'icon': Icons.account_balance_wallet, 'label': 'Deudas'},
    {'icon': Icons.insert_chart, 'label': 'Reportes'},
    {'icon': Icons.calendar_today, 'label': 'Calendario'},
    {'icon': Icons.location_city, 'label': 'Sedes'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Categorías arriba
            const Text(
              'Accesos rápidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categorias.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final cat = categorias[index];
                return AdminCategoryButton(
                  icon: cat['icon'],
                  label: cat['label'],
                  onTap: () {}, // Puedes agregar navegación
                );
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Resumen del mes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ResumenCard(
                  title: 'Ingresos',
                  amount: 'S/ 25,000',
                  color: Colors.green,
                ),
                ResumenCard(
                  title: 'Gastos',
                  amount: 'S/ 12,000',
                  color: Colors.red,
                ),
                ResumenCard(
                  title: 'Ganancia',
                  amount: 'S/ 13,000',
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Más vendidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
              title: const Text('Zapato X'),
              subtitle: const Text('150 vendidos'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),

            ListTile(
              leading: const CircleAvatar(child: Icon(Icons.shopping_cart)),
              title: const Text('Polo blanco'),
              subtitle: const Text('120 vendidos'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
