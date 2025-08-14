import "package:flutter/material.dart";

import "package:mobilemart/database/models/cart_item_model.dart";

class PriceSummery extends StatelessWidget {
  final List<CartItemModel> cartItems;
  const PriceSummery({super.key, required this.cartItems});
  int calculateTotal() {
    int total = 0;
    for (var item in cartItems) {
      final price = int.tryParse(item.price) ?? 0;
      final quantity = item.quantity;
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      'Total ${calculateTotal()}',
      style: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ));
  }
}
