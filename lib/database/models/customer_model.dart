import 'package:hive/hive.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 5)
class CustomerModel extends HiveObject {
  @HiveField(0)
  final String customerName;
  @HiveField(1)
  final String customerEmail;
  @HiveField(2)
  final String customerPhone;
  @HiveField(3)
  final String customerAdress;
  @HiveField(4)
  final List<String> productNames;

  @HiveField(5)
  final List<String> imagePaths;

  @HiveField(6)
  final List<int> quantities;

  @HiveField(7)
  final int total;
  @HiveField(8)
  final DateTime orderDate;
  @HiveField(9)
  final List<int>
      purchasePrices; // Add this field to store each product’s purchase price

  CustomerModel({
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerAdress,
    required this.productNames,
    required this.imagePaths,
    required this.quantities,
    required this.total,
    required this.orderDate,
    required this.purchasePrices,
  });
}
