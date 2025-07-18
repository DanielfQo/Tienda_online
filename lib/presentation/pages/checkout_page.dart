import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final double total;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.total,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String? _selectedPaymentMethod;
  final TextEditingController _addressController = TextEditingController();
  //String selectedPayment = 'Yape';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación de compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: widget.cartItems.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
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
                  '\$${widget.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Dirección
            TextField(
              controller: _addressController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Tu ubicación',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.orange, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Método de pago (ejemplo simple con Dropdown)
            DropdownButtonFormField<String>(
              value: _selectedPaymentMethod,
              items: ['Yape', 'Plin', 'PagoEfectivo']
              .map((method) => DropdownMenuItem(
                value: method,
                child: Text(method),
              ))
              .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Método de pago',
                labelStyle: const TextStyle(color: Colors.black),
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 2),
                ),
                border: const OutlineInputBorder( // <- también se puede incluir
                borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              dropdownColor: Colors.white,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Botón de registrar compra
            ElevatedButton(
              onPressed: () {
                // Lógica para procesar compra
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // texto blanco
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Registrar compra'),
            ),
          ],
        ),
      ),
    );
  }
}

