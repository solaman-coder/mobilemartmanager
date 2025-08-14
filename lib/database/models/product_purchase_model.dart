import 'package:hive/hive.dart';

part 'product_purchase_model.g.dart';

@HiveType(typeId: 6)
class ProductPurchaseModel extends HiveObject {
  @HiveField(0)
  final String modelName;

  @HiveField(1)
  final String brand;

  @HiveField(2)
  final int quantity;

  @HiveField(3)
  final int purchasePrice;

  @HiveField(4)
  final DateTime date;

  ProductPurchaseModel({
    required this.modelName,
    required this.brand,
    required this.quantity,
    required this.purchasePrice,
    required this.date,
  });
}
