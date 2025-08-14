import 'package:hive/hive.dart';

part 'product_model.g.dart'; // Needed for code generation

@HiveType(typeId: 1) // Make sure typeId is unique across all models
class ProductModel extends HiveObject {
  @HiveField(0)
  final String modelName;

  @HiveField(1)
  final String price;

  @HiveField(2)
  final String quantity;

  @HiveField(3)
  final String imagePath;
  @HiveField(4)
  final String brand;
  @HiveField(5)
  final String purchasePrice;

  @HiveField(6)
  final String mrpPrice;
  @HiveField(7)
  final String ram;

  @HiveField(8)
  final String frontCamera;

  @HiveField(9)
  final String backCamera;

  @HiveField(10)
  final String display;

  @HiveField(11)
  final String processor;

  @HiveField(12)
  final String battery;

  @HiveField(13)
  final String fastCharge;
  @HiveField(14)
  bool isActive;

  ProductModel({
    required this.modelName,
    required this.price,
    required this.quantity,
    required this.imagePath,
    required this.brand,
    required this.purchasePrice,
    required this.mrpPrice,
    required this.ram,
    required this.frontCamera,
    required this.backCamera,
    required this.display,
    required this.processor,
    required this.battery,
    required this.fastCharge,
    this.isActive = true,
  });
}
