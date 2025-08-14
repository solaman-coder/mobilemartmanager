import 'package:hive/hive.dart';
import 'package:mobilemart/database/models/expence_model.dart';

class ExpenseDb {
  static final _box = Hive.box<ExpenseModel>('expenses');

  static Future<void> addExpense(ExpenseModel expense) async {
    await _box.add(expense);
  }

  static List<ExpenseModel> getAllExpenses() {
    return _box.values.toList();
  }

  static List<ExpenseModel> getExpensesByDateRange(
      DateTime start, DateTime end) {
    return _box.values
        .where((expense) =>
            expense.date.isAfter(start.subtract(const Duration(days: 1))) &&
            expense.date.isBefore(end.add(const Duration(days: 1))))
        .toList();
  }
}
