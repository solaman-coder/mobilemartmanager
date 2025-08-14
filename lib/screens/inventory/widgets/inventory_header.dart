import 'package:flutter/material.dart';
import 'package:mobilemart/routes/app_routes.dart';

class InventoryHeader extends StatelessWidget {
  final Function(String) onSearchChanged;

  const InventoryHeader({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Inventory",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.addstock);
                },
                icon: const Icon(Icons.add, color: Colors.deepPurple),
                label: const Text(
                  "Add Product",
                  style: TextStyle(color: Colors.deepPurple),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),

          // Search
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: onSearchChanged, // Call the parent function
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: "Search your products",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
