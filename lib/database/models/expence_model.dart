import 'package:hive/hive.dart';

part 'expence_model.g.dart';

@HiveType(typeId: 7)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  final String category; // Rent, Electricity, Salary, etc.

  @HiveField(1)
  final int amount;

  @HiveField(2)
  final DateTime date;

  ExpenseModel({
    required this.category,
    required this.amount,
    required this.date,
  });
}
