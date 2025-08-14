import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilemart/routes/app_routes.dart';

import '../../database/fuctions/expence_db.dart';
import '../../database/models/expence_model.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<ExpenseModel> expenses = [];

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  void loadExpenses() {
    setState(() {
      expenses = ExpenseDb.getAllExpenses();
    });
  }

  void _showAddExpenseDialog() {
    String title = '';
    String amount = '';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(hintText: "Expense Title"),
              onChanged: (value) => title = value,
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(hintText: "Amount"),
              keyboardType: TextInputType.number,
              onChanged: (value) => amount = value,
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              if (title.trim().isEmpty || int.tryParse(amount) == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter valid data")),
                );
                return;
              }

              final expense = ExpenseModel(
                category: title.trim(),
                amount: int.parse(amount),
                date: DateTime.now(),
              );
              await ExpenseDb.addExpense(expense);
              loadExpenses();
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
        ),
        title: const Text("Expenses"),
      ),
      body: expenses.isEmpty
          ? const Center(child: Text("No expenses added yet"))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return ListTile(
                  leading: const Icon(Icons.money_off),
                  title: Text(e.category),
                  subtitle: Text(formatDate(e.date)),
                  trailing: Text("₹${e.amount}"),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddExpenseDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
