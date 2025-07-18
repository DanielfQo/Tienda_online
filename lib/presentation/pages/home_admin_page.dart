import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/light_color.dart';
import '../../routes/app_routes.dart';
import '../widgets/custom_button.dart';
import '../widgets/admin_category_button.dart';
import '../widgets/resumen_card.dart';
import '../widgets/ingresos_line_chart.dart';

class HomeAdminPage extends StatelessWidget {
  const HomeAdminPage({super.key});

  final List<Map<String, dynamic>> categorias = const [
    {'icon': Icons.people, 'label': 'Usuarios', 'route': AppRoutes.adminUsers},
    {
      'icon': Icons.inventory,
      'label': 'Productos',
      'route': AppRoutes.adminProducts,
    },
    {'icon': Icons.bar_chart, 'label': 'Ventas', 'route': AppRoutes.adminSales},
    {
      'icon': Icons.handshake,
      'label': 'Préstamos',
      'route': AppRoutes.adminLoans,
    },
    {
      'icon': Icons.money_off,
      'label': 'Gastos',
      'route': AppRoutes.adminExpenses,
    },
    {
      'icon': Icons.account_balance_wallet,
      'label': 'Deudas',
      'route': AppRoutes.adminDebts,
    },
    {
      'icon': Icons.insert_chart,
      'label': 'Reportes',
      'route': AppRoutes.adminReports,
    },
    {
      'icon': Icons.calendar_today,
      'label': 'Calendario',
      'route': AppRoutes.adminCalendar,
    },
    {
      'icon': Icons.location_city,
      'label': 'Sedes',
      'route': AppRoutes.adminBranches,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: Stack(
        children: [
          // Contenido principal
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Thunder Dashboard',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
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
                      onTap: () {
                        context.go(cat['route']);
                      },
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
                  'Ingresos semanales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                const IngresosLineChart(),
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

          // Botón X
          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.close, size: 28, color: Colors.black),
              onPressed: () => context.go(AppRoutes.initial),
            ),
          ),
        ],
      ),
    );
  }
}
