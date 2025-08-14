import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';
import 'package:mobilemart/screens/cart/cartcards.dart';
import '../../database/fuctions/CartDb.dart';
import '../../database/fuctions/product_db.dart';
import '../../routes/app_routes.dart';
import '../home/widgets/bottomnavigation.dart';
import 'appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      appBar: const CustomAppbar(title: 'Cart'),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<CartItemModel>('cart').listenable(),
        builder: (context, Box<CartItemModel> cartBox, _) {
          final cartItems = cartBox.values.toList();

          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemRow(
                      item: item,
                      onRemove: () {
                        // Increase inventory quantity
                        final products = ProductDb.getAll();
                        final productIndex = products.indexWhere(
                            (p) => products.indexOf(p) == item.productKey);
                        if (productIndex != -1) {
                          final product = products[productIndex];
                          final currentQuantity = int.parse(product.quantity);
                          ProductDb.updateQuantity(
                              item.productKey, currentQuantity + item.quantity);
                        }
                        // Remove from cart
                        Cartdb.removeItem(item.productKey);
                      },
                    );
                  },
                ),
              ),
              // Proceed to Checkout button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.checkout);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6B48FF),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
