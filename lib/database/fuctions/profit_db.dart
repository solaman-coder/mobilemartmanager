import 'package:mobilemart/database/fuctions/customer_db.dart';
import 'package:mobilemart/database/fuctions/expence_db.dart';
import 'package:mobilemart/screens/profit_pie/date_filter.dart';

class ProfitCalculator {
  static int getTotalIncome(DateRangeType rangeType) {
    final orders = CoustomerDb.getAllCheckouts()
        .where((o) => isInSelectedRange(o.orderDate, rangeType))
        .toList();
    return orders.fold(0, (sum, o) => sum + o.total);
  }

  static int getTotalPurchaseCost(DateRangeType rangeType) {
    final orders = CoustomerDb.getAllCheckouts()
        .where((o) => isInSelectedRange(o.orderDate, rangeType))
        .toList();
    int total = 0;
    for (var order in orders) {
      for (int i = 0; i < order.quantities.length; i++) {
        total += order.purchasePrices[i] * order.quantities[i];
      }
    }
    return total;
  }

  static int getTotalExpenses(DateRangeType rangeType) {
    final expenses = ExpenseDb.getAllExpenses()
        .where((e) => isInSelectedRange(e.date, rangeType))
        .toList();
    return expenses.fold(0, (sum, e) => sum + e.amount);
  }

  static int getProfit(DateRangeType rangeType) {
    return getTotalIncome(rangeType) -
        getTotalPurchaseCost(rangeType) -
        getTotalExpenses(rangeType);
  }
}
