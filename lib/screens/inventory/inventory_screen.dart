import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/screens/home/widgets/bottomnavigation.dart';
import 'package:mobilemart/screens/inventory/widgets/brand_list_widget.dart';
import 'package:mobilemart/screens/inventory/widgets/inventory_card.dart';
import 'package:mobilemart/screens/inventory/widgets/inventory_header.dart';
import '../../database/models/product_model.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String? selectedBrand;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            InventoryHeader(
              onSearchChanged: (query) {
                setState(() {
                  searchQuery = query.toLowerCase();
                });
              },
            ),
            const SizedBox(height: 10),
            BrandListWidget(
              selectedBrand: selectedBrand,
              onBrandSelected: (brand) {
                setState(() {
                  selectedBrand = brand;
                });
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable:
                    Hive.box<ProductModel>('products').listenable(),
                builder: (context, Box<ProductModel> box, _) {
                  List<ProductModel> products = box.values.toList();

                  // Filter by brand
                  if (selectedBrand != null) {
                    products = products
                        .where((p) =>
                            p.brand.toLowerCase() ==
                            selectedBrand!.toLowerCase())
                        .toList();
                  }

                  // Filter by search query
                  if (searchQuery.isNotEmpty) {
                    products = products.where((p) {
                      final combinedText =
                          '${p.modelName} ${p.price} ${p.ram}  ${p.frontCamera} ${p.backCamera} ${p.display} ${p.processor} ${p.battery} ${p.fastCharge}'
                              .toLowerCase();
                      return combinedText.contains(searchQuery);
                    }).toList();
                  }

                  if (products.isEmpty) {
                    return const Center(child: Text("No Products Found"));
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final key =
                          box.keyAt(box.values.toList().indexOf(product));
                      return InventoryCard(product: product, productKey: key);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
