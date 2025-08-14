import 'package:hive/hive.dart';
import '../models/product_purchase_model.dart';

class ProductPurchaseDb {
  static final _box = Hive.box<ProductPurchaseModel>('product_purchases');

  /// 🔹 Add a new stock purchase
  static Future<void> addPurchase(ProductPurchaseModel purchase) async {
    await _box.add(purchase);
  }

  /// 🔹 Get all purchase records
  static List<ProductPurchaseModel> getAllPurchases() {
    return _box.values.toList();
  }

  /// 🔹 Filter by time (useful for reports later)
  static List<ProductPurchaseModel> getPurchasesByDateRange(
      DateTime start, DateTime end) {
    return _box.values
        .where((purchase) =>
            purchase.date.isAfter(start.subtract(const Duration(days: 1))) &&
            purchase.date.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }
}
