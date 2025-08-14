import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilemart/database/models/customer_model.dart';

class CustomerCard extends StatelessWidget {
  final CustomerModel customer;
  final VoidCallback onTap;

  const CustomerCard({super.key, required this.customer, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(customer.customerName,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("₹${customer.total}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "${customer.orderDate.day} ${_monthName(customer.orderDate.month)} ${customer.orderDate.year}",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              // Product List (first two)
              Column(
                children: List.generate(
                  customer.productNames.length,
                  (i) => ListTile(
                    leading:
                        Image.file(File(customer.imagePaths[i]), width: 40),
                    title: Text(customer.productNames[i]),
                    subtitle: Text("Qty: ${customer.quantities[i]}"),
                    trailing: Text(
                        "₹${(int.tryParse(customer.total.toString()) ?? 0) ~/ customer.quantities.length}"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }
}
