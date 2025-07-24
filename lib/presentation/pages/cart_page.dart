import 'package:flutter/material.dart';
import 'package:tienda_online/presentation/pages/checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO conectar con el provider del carrito de compras
    final cartItems = [
      {'name': 'Producto 1', 'price': 20.0, 'quantity': 1},
      {'name': 'Producto 2', 'price': 15.0, 'quantity': 2},
    ];


    final total = cartItems.fold(0.0, (sum, item) {
      return sum + (item['price'] as double) * (item['quantity'] as int);
    });

    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    title: Text(item['name'].toString()),
                    subtitle: Text('Cantidad: ${item['quantity']}'),
                    trailing: Text(
                      '\$${(item['price'] as double) * (item['quantity'] as int)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),

            const Divider(thickness: 1.5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutPage(
                      cartItems: cartItems,
                      total: total,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
              ),
              child: const Text('Proceder al pago'),
            ),
          ],
        ),
    );
  }
}
