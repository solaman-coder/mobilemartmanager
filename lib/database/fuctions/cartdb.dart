import 'package:hive/hive.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';

class Cartdb {
  static final _cartBox = Hive.box<CartItemModel>('cart');
  static List<CartItemModel> getAll() => _cartBox.values.toList();
  static void addItem(CartItemModel item) {
    _cartBox.add(item);
  }

  static void updateQuantity(int productKey, int newQuantity) {
    final itemIndex = _cartBox.values
        .toList()
        .indexWhere((item) => item.productKey == productKey);
    if (itemIndex != -1) {
      final item = _cartBox.getAt(itemIndex)!;
      final updatedItem = CartItemModel(
        modelName: item.modelName,
        price: item.price,
        quantity: newQuantity,
        imagePath: item.imagePath,
        brand: item.brand,
        productKey: item.productKey,
      );
      _cartBox.putAt(itemIndex, updatedItem);
    }
  }

  static void removeItem(int productKey) {
    final itemIndex = _cartBox.values
        .toList()
        .indexWhere((item) => item.productKey == productKey);
    if (itemIndex != -1) {
      _cartBox.deleteAt(itemIndex);
    }
  }

  static void clearCart() {
    _cartBox.clear();
  }
}
