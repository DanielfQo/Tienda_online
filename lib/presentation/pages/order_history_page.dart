import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/light_color.dart';
import '../../routes/app_routes.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  final List<Map<String, dynamic>> orders = const [
    {
      'date': '20/7/2024',
      'code': 'APE04670237',
      'items': 1,
      'total': 129,
      'month': 'JULIO 2024',
    },
    {
      'date': '25/5/2024',
      'code': 'APE04456130',
      'items': 3,
      'total': 551,
      'month': 'MAYO 2024',
    },
    {
      'date': '7/3/2024',
      'code': 'APE04245113',
      'items': 1,
      'total': 329,
      'month': 'MARZO 2024',
    },
    {
      'date': '18/1/2024',
      'code': 'APE04123471',
      'items': 1,
      'total': 217,
      'month': 'ENERO 2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    String? lastMonth;

    return Scaffold(
      backgroundColor: LightColor.backgroundProfile,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Center(
                    child: Text(
                      'PEDIDOS',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 28),
                      onPressed: () => context.go(AppRoutes.profile),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'PEDIDOS REALIZADOS',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  final isNewMonth = order['month'] != lastMonth;
                  lastMonth = order['month'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isNewMonth)
                        Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            order['month'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          title: Text(
                            'Pedido realizado el: ${order['date']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pedido: ${order['code']}'),
                                Text(
                                  'Artículo${order['items'] > 1 ? 's' : ''}: ${order['items']}',
                                ),
                                Text('Total: S/.${order['total']}'),
                              ],
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Navegar a detalles de pedido
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
