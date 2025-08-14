import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobilemart/database/fuctions/customer_db.dart';
import 'package:mobilemart/database/models/product_model.dart';

class SalesOverviewCard extends StatefulWidget {
  const SalesOverviewCard({super.key});

  @override
  State<SalesOverviewCard> createState() => _SalesOverviewCardState();
}

class _SalesOverviewCardState extends State<SalesOverviewCard> {
  int todaySales = 0;
  int totalProductQty = 0;
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Get today's date range
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    //  Calculate today's sales
    final allOrders = CoustomerDb.getAllCheckouts();
    final todayOrders = allOrders
        .where((order) =>
            order.orderDate.isAfter(startOfDay) &&
            order.orderDate.isBefore(endOfDay))
        .toList();
    final todaySalesAmount =
        todayOrders.fold(0, (sum, order) => sum + order.total);

    //  Total product quantity
    final productBox = Hive.box<ProductModel>('products');
    int totalQty = 0;
    for (var product in productBox.values) {
      final qty = int.tryParse(product.quantity) ?? 0;
      totalQty += qty;
    }

    setState(() {
      todaySales = todaySalesAmount;
      totalProductQty = totalQty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 3, 57, 98),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text("Today's Sales",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: const Color.fromARGB(217, 255, 255, 255))),
              Text("₹$todaySales",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  )),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 30,
              // ),
              Text("Products",
                  style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.w900,
                  )),
              Text("$totalProductQty",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  )),
              // SizedBox(
              //   height: 30,
              // ),
            ],
          )
        ],
      ),
    );
  }
}
