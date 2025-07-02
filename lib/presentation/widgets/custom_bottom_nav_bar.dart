import 'package:flutter/material.dart';
import '../../core/theme/light_color.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      backgroundColor: LightColor.background,
      selectedItemColor: Colors.white,
      unselectedItemColor: LightColor.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onTap,
      items: [
        _buildNavItem(Icons.home, 0),
        _buildNavItem(Icons.shopping_bag, 1),
        _buildNavItem(Icons.favorite_border, 2),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, int index) {
    final bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      label: '',
      icon: isSelected
          ? Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: LightColor.orange,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: LightColor.orange.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white),
            )
          : Icon(icon),
    );
  }
}
