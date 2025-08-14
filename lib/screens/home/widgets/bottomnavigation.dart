import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const BottomNavBar({super.key, required this.currentIndex});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return; // Avoid reloading same screen
    String targetRoute = '';
    switch (index) {
      case 0:
        targetRoute = AppRoutes.home;
        break;
      case 1:
        targetRoute = AppRoutes.inventory;
        break;
      case 2:
        targetRoute = AppRoutes.cart;

        break;
      case 3:
        targetRoute = AppRoutes.profile;
        break;
    }
    Navigator.pushNamedAndRemoveUntil(
      context,
      targetRoute,
      (route) => false, // Remove entire navigation stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2), label: "Inventory"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
