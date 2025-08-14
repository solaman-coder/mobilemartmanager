import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';

import '../../database/fuctions/CartDb.dart';
import '../../database/fuctions/product_db.dart';

class CartItemRow extends StatefulWidget {
  final CartItemModel item;
  final VoidCallback onRemove;

  const CartItemRow({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  State<CartItemRow> createState() => _CartItemRowState();
}

class _CartItemRowState extends State<CartItemRow> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.item.quantity;
  }

  void _updateQuantity(int newQuantity) {
    // Calculate the difference in quantity
    final quantityDifference = newQuantity - quantity;

    // Update inventory quantity
    final products = ProductDb.getAll();
    final productIndex = products
        .indexWhere((p) => products.indexOf(p) == widget.item.productKey);
    if (productIndex != -1) {
      final product = products[productIndex];
      final currentInventoryQuantity = int.parse(product.quantity);

      // Check if there's enough stock to increase quantity
      if (quantityDifference > 0 &&
          currentInventoryQuantity < quantityDifference) {
        return; // Not enough stock to increase quantity
      }

      // Update inventory quantity
      ProductDb.updateQuantity(
        widget.item.productKey,
        currentInventoryQuantity - quantityDifference,
      );

      // Update cart quantity
      setState(() {
        quantity = newQuantity;
      });
      Cartdb.updateQuantity(widget.item.productKey, newQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Item image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(widget.item.imagePath),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Item name and remove button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.modelName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: widget.onRemove,
                  child: const Text(
                    'Remove',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Quantity selector and price
          Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          _updateQuantity(quantity - 1);
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _updateQuantity(quantity + 1);
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Text(
                '₹${int.parse(widget.item.price) * quantity}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
