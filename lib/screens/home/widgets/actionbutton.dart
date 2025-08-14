import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.money_off, "Add expence", () {
          Navigator.pushNamed(context, AppRoutes.expence);
        }),
        _buildActionButton(Icons.attach_money, "Money Flow", () {
          Navigator.pushReplacementNamed(context, AppRoutes.profitpie);
        }),
        _buildActionButton(Icons.add, "Add Stock", () {
          Navigator.pushReplacementNamed(context, AppRoutes.addstock);
        }),
        _buildActionButton(Icons.people, "Customers", () {
          Navigator.pushReplacementNamed(context, AppRoutes.coustomers);
        }),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 216, 220, 224),
            radius: 24,
            child:
                Icon(icon, color: const Color.fromARGB(255, 0, 0, 0), size: 28),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
