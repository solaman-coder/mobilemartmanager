import 'dart:io';

import 'package:flutter/material.dart';

import 'package:mobilemart/database/models/cart_item_model.dart';

class ProductCard extends StatelessWidget {
  final CartItemModel item;
  const ProductCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(item.imagePath),
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  item.modelName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('qnty : ${item.quantity}',
                    style: const TextStyle(color: Colors.black))
              ])),
          Text(
            '₹${item.price}',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
