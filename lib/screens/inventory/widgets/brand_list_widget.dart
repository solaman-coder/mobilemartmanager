import 'package:flutter/material.dart';
import 'package:mobilemart/database/fuctions/brand_db.dart';
import 'package:mobilemart/database/fuctions/product_db.dart';
import 'package:mobilemart/database/models/brand_model.dart';

class BrandListWidget extends StatefulWidget {
  final String? selectedBrand;
  final Function(String?) onBrandSelected;

  const BrandListWidget({
    super.key,
    required this.selectedBrand,
    required this.onBrandSelected,
  });

  @override
  State<BrandListWidget> createState() => _BrandListWidgetState();
}

class _BrandListWidgetState extends State<BrandListWidget> {
  List<BrandModel> brands = [];

  @override
  void initState() {
    super.initState();
    loadBrands();
  }

  void loadBrands() {
    setState(() {
      brands = BrandDb.getBrands();
    });
  }

  void showAddBrandDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Brand'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter brand name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              String newBrand = controller.text.trim();
              if (newBrand.isEmpty) return;

              bool exists = brands
                  .any((b) => b.name.toLowerCase() == newBrand.toLowerCase());

              if (exists) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Brand already exists!')),
                );
              } else {
                await BrandDb.addBrand(newBrand);
                loadBrands();
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void showEditDeleteDialog(int index) {
    final controller = TextEditingController(text: brands[index].name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit/Delete Brand'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter new brand name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final brandToDelete = brands[index].name;
              final brandBox = BrandDb.getBrandBox();
              final key = brandBox.keyAt(index);
              await BrandDb.deleteBrand(key);
              await ProductDb.disableProductsByBrand(brandToDelete);
              loadBrands();
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
          ElevatedButton(
            onPressed: () {
              String newName = controller.text.trim();
              if (newName.isEmpty) return;

              bool isDuplicate = brands.any((b) =>
                  b.name.toLowerCase() == newName.toLowerCase() &&
                  b.name.toLowerCase() != brands[index].name.toLowerCase());

              if (isDuplicate) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Brand already exists!')),
                );
              } else {
                BrandDb.updateBrand(index, newName);
                loadBrands();
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('No brands yet. Please add brand.'),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blue),
              onPressed: showAddBrandDialog,
            ),
          ],
        ),
      );
    }

    // Normal UI when brands exist
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16, right: 8),
        itemCount: brands.length + 2, // All + Add
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GestureDetector(
                onTap: () => widget.onBrandSelected(null),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: widget.selectedBrand == null
                      ? const Color.fromARGB(255, 105, 187, 254)
                      : Colors.grey[300],
                  child: const Text(
                    'All',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ),
            );
          }

          if (index == brands.length + 1) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: showAddBrandDialog,
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 45, 145, 227),
                  child: Icon(Icons.add, color: Colors.white),
                ),
              ),
            );
          }

          final brand = brands[index - 1];
          final isSelected = brand.name.toLowerCase() ==
              (widget.selectedBrand?.toLowerCase() ?? '');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => widget.onBrandSelected(brand.name),
              onLongPress: () => showEditDeleteDialog(index - 1),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: isSelected
                    ? const Color.fromARGB(255, 109, 185, 248)
                    : Colors.grey[200],
                child: Text(
                  brand.name.toLowerCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
