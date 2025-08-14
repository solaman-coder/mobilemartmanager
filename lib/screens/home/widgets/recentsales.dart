import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:mobilemart/screens/customers/customersales_screen.dart';

class RecentSalesList extends StatelessWidget {
  const RecentSalesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<CustomerModel>('customer').listenable(),
      builder: (context, Box<CustomerModel> box, _) {
        final sales = box.values.toList().reversed.toList();
        if (sales.isEmpty) {
          return const Text('No recent sales');
        }
        final allCustomers = box.values.toList();
        final latestSales = allCustomers.reversed.take(2).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recent Sales",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CustomerSalesScreen(),
                        ));
                  },
                  child: const Text("View all",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...latestSales.map((customer) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(customer.productNames.first),
                  subtitle: Text("Sold to ${customer.customerName}"),
                  trailing: Text("₹${customer.total}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
