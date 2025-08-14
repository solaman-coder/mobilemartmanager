import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/product_model.dart';

class LowStockFullScreen extends StatelessWidget {
  const LowStockFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Low Stock Products")),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ProductModel>('products').listenable(),
        builder: (context, Box<ProductModel> box, _) {
          final lowStocks = box.values
              .where((p) =>
                  int.tryParse(p.quantity) != null &&
                  int.parse(p.quantity) < 10)
              .toList();

          if (lowStocks.isEmpty) {
            return const Center(child: Text("No Low Stock Items"));
          }

          return ListView.builder(
            itemCount: lowStocks.length,
            itemBuilder: (context, index) {
              final product = lowStocks[index];
              return ListTile(
                leading:
                    Image.file(File(product.imagePath), width: 50, height: 50),
                title: Text(product.modelName),
                subtitle: Text("Only ${product.quantity} Left",
                    style: const TextStyle(color: Colors.red)),
              );
            },
          );
        },
      ),
    );
  }
}
