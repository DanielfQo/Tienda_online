import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({super.key});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.directions_run, 'label': 'Sneakers'},
    {'icon': Icons.checkroom, 'label': 'Jacket'},
    {'icon': Icons.watch, 'label': 'Watch'},
    {'icon': Icons.phone_iphone, 'label': 'Phone'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(12),
                color: isSelected ? Colors.white : Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(
                    category['icon'],
                    color: isSelected ? Colors.orange : Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    category['label'],
                    style: TextStyle(
                      color: isSelected ? Colors.orange : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
