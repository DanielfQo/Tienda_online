import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/light_color.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/admin_app_bar.dart';

class AdminSalesPage extends StatelessWidget {
  const AdminSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> ventas = [
      {'id': 101, 'fecha': '2025-07-18', 'total': 250.00},
      {'id': 102, 'fecha': '2025-07-17', 'total': 450.50},
      {'id': 103, 'fecha': '2025-07-16', 'total': 320.75},
      {'id': 104, 'fecha': '2025-07-15', 'total': 190.00},
    ];

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      appBar: const AdminAppBar(
        title: 'Ventas',
        returnRoute: AppRoutes.homeAdmin,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: ventas.length,
          itemBuilder: (context, index) {
            final venta = ventas[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: LightColor.orange.withOpacity(0.2),
                  child: Text('${venta['id']}'),
                ),
                title: Text('Venta #${venta['id']}'),
                subtitle: Text('Fecha: ${venta['fecha']}'),
                trailing: Text(
                  'S/ ${venta['total'].toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                onTap: () {
                  // Futuro: ir a detalles de la venta
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: LightColor.orange,
        child: const Icon(Icons.add),
        onPressed: () {
          // Futuro: crear nueva venta manualmente
        },
      ),
    );
  }
}
