import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobilemart/database/fuctions/customer_db.dart';
import 'package:mobilemart/database/fuctions/expence_db.dart';
import 'package:mobilemart/database/fuctions/profit_db.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/screens/profit_pie/date_filter.dart';

class ProfitPieScreen extends StatefulWidget {
  const ProfitPieScreen({super.key});

  @override
  State<ProfitPieScreen> createState() => _ProfitPieScreenState();
}

class _ProfitPieScreenState extends State<ProfitPieScreen> {
  String _selectedRange = 'Month';

  DateRangeType get selectedRangeType {
    switch (_selectedRange) {
      case 'Today':
        return DateRangeType.today;
      case 'Week':
        return DateRangeType.week;
      case 'Year':
        return DateRangeType.year;
      case 'Month':
      default:
        return DateRangeType.month;
    }
  }

  /// Formats numbers into short forms like 1k, 1.5M
  String formatNumber(num value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    } else {
      return value.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = ProfitCalculator.getTotalIncome(selectedRangeType);
    final totalExpenses =
        ProfitCalculator.getTotalPurchaseCost(selectedRangeType) +
            ProfitCalculator.getTotalExpenses(selectedRangeType);
    final profit = totalIncome - totalExpenses;

    final recentOrders = CoustomerDb.getAllCheckouts()
        .where((o) => isInSelectedRange(o.orderDate, selectedRangeType))
        .toList()
        .reversed
        .toList();

    final recentExpenses = ExpenseDb.getAllExpenses()
        .where((e) => isInSelectedRange(e.date, selectedRangeType))
        .toList()
        .reversed
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit Pie'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.restorablePushReplacementNamed(context, AppRoutes.home);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DropdownButton<String>(
                value: _selectedRange,
                onChanged: (newValue) {
                  setState(() {
                    _selectedRange = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(value: 'Today', child: Text('Today')),
                  DropdownMenuItem(value: 'Week', child: Text('This week')),
                  DropdownMenuItem(value: 'Month', child: Text('This Month')),
                  DropdownMenuItem(value: 'Year', child: Text('This Year')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: totalIncome == 0 && totalExpenses == 0 && profit == 0
                  ? const Center(
                      child: Text(
                        'No data available for this period.',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: 1.3,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 40,
                          sectionsSpace: 4,
                          sections: [
                            PieChartSectionData(
                              color: Colors.pinkAccent,
                              value: totalExpenses.toDouble(),
                              title: formatNumber(totalExpenses),
                              titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            PieChartSectionData(
                              color: Colors.blueAccent,
                              value: totalIncome.toDouble(),
                              title: formatNumber(totalIncome),
                              titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            PieChartSectionData(
                              color: Colors.greenAccent,
                              value: profit.toDouble(),
                              title: formatNumber(profit),
                              titleStyle: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(backgroundColor: Colors.greenAccent, radius: 6),
                SizedBox(width: 6),
                Text("Profit"),
                SizedBox(width: 16),
                CircleAvatar(backgroundColor: Colors.pinkAccent, radius: 6),
                SizedBox(width: 6),
                Text("Expense"),
                SizedBox(width: 16),
                CircleAvatar(backgroundColor: Colors.blueAccent, radius: 6),
                SizedBox(width: 6),
                Text("Income"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Recent Transactions",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  if (recentOrders.isNotEmpty)
                    ListTile(
                      title: const Text("Store sales"),
                      trailing: Text(
                        "₹ ${recentOrders.first.total}",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ...recentExpenses.map(
                    (expense) => ListTile(
                      title: Text(expense.category),
                      trailing: Text(
                        "₹ ${expense.amount}",
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
