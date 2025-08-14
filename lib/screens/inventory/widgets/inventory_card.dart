import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';
import 'package:mobilemart/database/models/product_model.dart';
import 'package:mobilemart/database/fuctions/CartDb.dart';
import 'package:mobilemart/database/fuctions/product_db.dart';
import 'package:mobilemart/screens/inventory/widgets/view_product_spec_screen.dart';
import 'edit_product_screen.dart';

class InventoryCard extends StatelessWidget {
  final ProductModel product;
  final int productKey;

  const InventoryCard({
    super.key,
    required this.product,
    required this.productKey,
  });

  void _toggleCartItem(BuildContext context) {
    final cartBox = Hive.box<CartItemModel>('cart');
    final isInCart =
        cartBox.values.any((item) => item.productKey == productKey);

    if (isInCart) {
      final cartItem =
          cartBox.values.firstWhere((item) => item.productKey == productKey);
      Cartdb.removeItem(productKey);
      final currentQuantity = int.parse(product.quantity);
      ProductDb.updateQuantity(productKey, currentQuantity + cartItem.quantity);
    } else {
      final currentQuantity = int.parse(product.quantity);
      if (currentQuantity <= 0) return;
      ProductDb.updateQuantity(productKey, currentQuantity - 1);
      Cartdb.addItem(CartItemModel(
        modelName: product.modelName,
        price: product.price,
        quantity: 1,
        imagePath: product.imagePath,
        brand: product.brand,
        productKey: productKey,
      ));
    }
  }

  void _showUpdateQuantityDialog(BuildContext context) {
    final TextEditingController qtyController =
        TextEditingController(text: product.quantity);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Quantity"),
          content: TextField(
            controller: qtyController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Enter new quantity",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                final newQty = int.tryParse(qtyController.text);
                if (newQty != null && newQty >= 0) {
                  ProductDb.updateQuantity(productKey, newQty);
                }
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Manage Product'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditProductScreen(
                    product: product,
                    productKey: productKey,
                  ),
                ),
              );
            },
            child: const Text('Edit'),
          ),
          SimpleDialogOption(
            onPressed: () {
              ProductDb.deleteProduct(productKey);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product deleted')),
              );
            },
            child: const Text('Delete'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              _showUpdateQuantityDialog(context);
            },
            child: const Text('Update Qty'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context); // Just closes the dialog
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = !product.isActive;

    return GestureDetector(
      onTap: () {
        if (!isDisabled) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductSpecScreen(product: product),
            ),
          );
        }
      },
      child: ValueListenableBuilder(
        valueListenable: Hive.box<CartItemModel>('cart').listenable(),
        builder: (context, Box<CartItemModel> cartBox, _) {
          final isInCart =
              cartBox.values.any((item) => item.productKey == productKey);

          return Opacity(
            opacity: isDisabled ? 0.5 : 1.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
              decoration: BoxDecoration(
                color: isDisabled ? Colors.grey[300] : Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 89,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 218, 233, 249),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: 80,
                              width: 51,
                              color: Colors.blue,
                              child: Image.file(
                                File(product.imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (isDisabled)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                "DISABLED",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Bag icon (disabled if product is inactive)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () => _toggleCartItem(context),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isInCart ? Colors.blue[100] : Colors.white,
                            ),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 18,
                              color: isInCart ? Colors.blue : Colors.grey[800],
                            ),
                          ),
                        ),
                      ),

                      // Pencil icon (disabled if product is inactive)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () => _showOptionsMenu(context),
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 14,
                            child: Icon(Icons.edit,
                                size: 16, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.brand,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product.modelName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "₹${product.price}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  Text(
                    "Qty: ${product.quantity}",
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
