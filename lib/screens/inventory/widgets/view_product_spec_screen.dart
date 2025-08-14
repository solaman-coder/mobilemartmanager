import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobilemart/database/models/product_model.dart';

class ProductSpecScreen extends StatelessWidget {
  final ProductModel product;

  const ProductSpecScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Specification")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(
              File(product.imagePath),
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            _specRow("Brand", product.brand),
            _specRow("Model", product.modelName),
            _specRow("MRP", "₹${product.mrpPrice}"),
            _specRow("Selling Price", "₹${product.price}"),
            _specRow("Purchase Price", "₹${product.purchasePrice}"),
            _specRow("Quantity", product.quantity),
            _specRow("RAM", product.ram),
            _specRow("Display", product.display),
            _specRow("Processor", product.processor),
            _specRow("Front Camera", product.frontCamera),
            _specRow("Back Camera", product.backCamera),
            _specRow("Battery", product.battery),
            _specRow("Fast Charging", product.fastCharge),
          ],
        ),
      ),
    );
  }

  Widget _specRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text("$title:",
                  style: const TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
