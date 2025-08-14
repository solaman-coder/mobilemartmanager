import 'package:hive/hive.dart';
part 'cart_item_model.g.dart';

@HiveType(typeId: 4)
class CartItemModel {
  @HiveField(0)
  final String modelName;
  @HiveField(1)
  final String price;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final String imagePath;
  @HiveField(4)
  final String brand;
  @HiveField(5)
  final int productKey;

  CartItemModel(
      {required this.modelName,
      required this.price,
      required this.quantity,
      required this.imagePath,
      required this.brand,
      required this.productKey});
}
