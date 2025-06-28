import 'package:flutter/material.dart';
import '../../core/theme/light_color.dart';

class CategorySelector extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final Function(int) onSelect;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? LightColor.background : Colors.transparent,
                border: Border.all(
                  color: isSelected ? LightColor.orange : LightColor.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(category['icon'], width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text(
                    category['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
