import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/customer_db.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/screens/customers/customer_card.dart';
import 'package:mobilemart/screens/customers/customerdetailes_screen.dart';
import 'package:mobilemart/theme/color_theme.dart';

enum TimeFilter { today, week, month, year }

class CustomerSalesScreen extends StatefulWidget {
  const CustomerSalesScreen({super.key});

  @override
  State<CustomerSalesScreen> createState() => _CustomerSalesScreenState();
}

class _CustomerSalesScreenState extends State<CustomerSalesScreen> {
  TimeFilter selectedFilter = TimeFilter.today;
  List<CustomerModel> allOrders = [];
  List<CustomerModel> filteredOrders = [];

  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    allOrders = CoustomerDb.getAllCheckouts();
    _applyFilter();
  }

  void _applyFilter() {
    final now = DateTime.now();
    List<CustomerModel> timeFiltered = allOrders.where((order) {
      final orderDate = order.orderDate;
      switch (selectedFilter) {
        case TimeFilter.today:
          return isSameDay(orderDate, now);
        case TimeFilter.week:
          return now.difference(orderDate).inDays < 7;
        case TimeFilter.month:
          return orderDate.month == now.month && orderDate.year == now.year;
        case TimeFilter.year:
          return orderDate.year == now.year;
      }
    }).toList();

    //  search filter
    setState(() {
      filteredOrders = timeFiltered.where((order) {
        return order.customerName
            .toLowerCase()
            .contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int get totalSales {
    return filteredOrders.fold(0, (sum, order) => sum + order.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Customers",
          style: TextStyle(color: AppColors.background),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.background),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search customers...",
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  searchQuery = value;
                  _applyFilter();
                },
              ),
            ),
          ),

          // Filter Tabs
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: TimeFilter.values.map((filter) {
                final label =
                    filter.name[0].toUpperCase() + filter.name.substring(1);
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedFilter = filter;
                      _applyFilter();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedFilter == filter
                        ? Colors.blue
                        : Colors.grey[300],
                    foregroundColor:
                        selectedFilter == filter ? Colors.white : Colors.black,
                  ),
                  child: Text(label),
                );
              }).toList(),
            ),
          ),

          // Customer Cards or No Results
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(child: Text("No results found"))
                : ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (context, index) {
                      final customer = filteredOrders[index];
                      return CustomerCard(
                        customer: customer,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  CustomerDetailScreen(customer: customer),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),

          // Bottom Sales Summary
          Container(
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            color: Colors.grey[100],
            child: Text(
              'Total Sale: ₹$totalSales',
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
