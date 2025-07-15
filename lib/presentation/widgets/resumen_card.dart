import 'package:flutter/material.dart';

class ResumenCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;

  const ResumenCard({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.15),
      child: Container(
        padding: const EdgeInsets.all(12),
        width: 100,
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(amount, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
