import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/CartDb.dart';
import 'package:mobilemart/database/fuctions/customer_db.dart';
import 'package:mobilemart/database/fuctions/product_db.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:mobilemart/screens/checkout/cutomer_detail_field.dart';
import 'package:mobilemart/screens/checkout/paymentscreen.dart';

import 'package:mobilemart/screens/checkout/price_summary.dart';
import 'package:mobilemart/screens/checkout/product_card.dart';
import 'package:mobilemart/screens/checkout/save_button.dart';
import 'package:mobilemart/theme/color_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isSaving = false; // default: not saving
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  List<CartItemModel> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  void _loadCartItems() {
    setState(() {
      cartItems = Cartdb.getAll();
    });
  }

  num totalprice(cartItems) {
    num total = 0;
    for (var item in cartItems) {
      final price = int.tryParse(item.price) ?? 0.0;
      final quantity = item.quantity;
      total += price * quantity;
    }
    return total;
  }

  void saveOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    } else {
      setState(() {
        isSaving = true; // disable button
      });

      final productNames = cartItems.map((item) => item.modelName).toList();
      final imagepaths = cartItems.map((item) => item.imagePath).toList();
      final quantities = cartItems.map((item) => item.quantity).toList();
      final purchasePrices = cartItems.map((item) {
        final product = ProductDb.getByKey(item.productKey);
        return int.tryParse(product?.purchasePrice ?? '0') ?? 0;
      }).toList();

      final newcustomer = CustomerModel(
        customerName: nameController.text.trim(),
        customerEmail: emailController.text,
        customerPhone: phoneController.text,
        customerAdress: addressController.text,
        productNames: productNames,
        imagePaths: imagepaths,
        quantities: quantities,
        purchasePrices: purchasePrices,
        total: totalprice(cartItems).toInt(),
        orderDate: DateTime.now(),
      );
      await CoustomerDb.saveUserCheckout(newcustomer);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('order saved successfully')));
      setState(() {
        isSaving = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReviewAndPaymentScreen(
            customer: newcustomer,
            cartItems: cartItems,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('checkout'),
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...cartItems.map((item) => ProductCard(item: item)),
              SizedBox(
                height: 24,
              ),
              Text(
                'Customer Detsils',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              CustomerDetailFields(
                formKey: _formKey,
                nameController: nameController,
                phoneController: phoneController,
                addressController: addressController,
                emailController: emailController,
              ),
              SizedBox(
                height: 20,
              ),
              PriceSummery(
                cartItems: cartItems,
              ),
              SizedBox(
                height: 20,
              ),
              SaveButton(onpressed: isSaving ? null : saveOrder),
            ],
          )),
    );
  }
}
