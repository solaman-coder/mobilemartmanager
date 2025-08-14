import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/CartDb.dart';

import 'package:mobilemart/database/models/cart_item_model.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:mobilemart/routes/app_routes.dart';
import '../../theme/color_theme.dart';

class ReviewAndPaymentScreen extends StatefulWidget {
  final CustomerModel customer;
  final List<CartItemModel> cartItems;

  const ReviewAndPaymentScreen({
    super.key,
    required this.customer,
    required this.cartItems,
  });

  @override
  State<ReviewAndPaymentScreen> createState() => _ReviewAndPaymentScreenState();
}

class _ReviewAndPaymentScreenState extends State<ReviewAndPaymentScreen> {
  String selectedPayamentMethod = 'Cash';
  final List<String> paymentoption = ['Cash', 'Card', 'Cheque'];

  int calculateTotal() {
    int total = 0;
    for (var item in widget.cartItems) {
      final price = int.tryParse(item.price) ?? 0;
      total += price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final int totalAmout = calculateTotal();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Products list
            const Text('Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            ...widget.cartItems.map((item) {
              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
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
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.modelName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text('Qty: ${item.quantity}')
                        ],
                      ),
                    ),
                    Text('₹${item.price}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            }),

            const SizedBox(height: 20),

            //  Customer Details section
            const Text('Customer Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.customer.customerName,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(widget.customer.customerEmail),
                  Text('+91 ${widget.customer.customerPhone}'),
                  Text(widget.customer.customerAdress),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //  Payment Method
            const Text("Payment Method",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEBFF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedPayamentMethod,
                  items: paymentoption.map((method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPayamentMethod = value!;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  Total Price
            Text(
              'Total: ₹$totalAmout',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            const SizedBox(height: 24),

            //  Proceed Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Cartdb.clearCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Payment Done")));
                  Navigator.pushReplacementNamed(context, AppRoutes.cart);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Proceed and Pay',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
