import 'package:flutter/material.dart';

// class LowStockAlert extends StatelessWidget {
//   const LowStockAlert({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text("Low Stocks Alert",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             Text("View all", style: TextStyle(color: Colors.blue))
//           ],
//         ),
//         const SizedBox(height: 10),
//         _buildStockItem(
//             "iPhone 16", "Only 2 Left", "assets/images/download (2).jpeg"),
//         _buildStockItem("iPhone 16 Pro Max", "Only 10 Left",
//             "assets/images/download (2).jpeg"),
//       ],
//     );
//   }

//   Widget _buildStockItem(String product, String stock, String imagePath) {
//     return ListTile(
//       leading: Image.asset(imagePath, width: 40, height: 40),
//       title: Text(product),
//       subtitle: Text(stock, style: const TextStyle(color: Colors.red)),
//     );
//   }
// }
import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/product_model.dart';
import 'package:mobilemart/screens/home/widgets/lowStockFullScreen.dart';

class LowStockAlert extends StatelessWidget {
  const LowStockAlert({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Hive.isBoxOpen('products')) {
      return const SizedBox(); // Or CircularProgressIndicator
    }
    return ValueListenableBuilder(
      valueListenable: Hive.box<ProductModel>('products').listenable(),
      builder: (context, Box<ProductModel> box, _) {
        final lowStocks = box.values
            .where((p) =>
                int.tryParse(p.quantity) != null && int.parse(p.quantity) < 10)
            .toList();

        // Show only 2 items here
        final latestLowStock = lowStocks.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Low Stocks Alert",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LowStockFullScreen(),
                        ));
                  },
                  child: const Text("View all",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...latestLowStock.map((product) => ListTile(
                  leading: Image.file(File(product.imagePath),
                      width: 40, height: 40),
                  title: Text(product.modelName),
                  subtitle: Text(
                    "Only ${product.quantity} Left",
                    style: const TextStyle(color: Colors.red),
                  ),
                )),
          ],
        );
      },
    );
  }
}
