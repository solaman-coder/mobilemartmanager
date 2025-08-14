import 'package:flutter/material.dart';

import '../../../database/fuctions/brand_db.dart';

class AddStockFields extends StatefulWidget {
  final TextEditingController modelController;
  final TextEditingController priceController;
  final TextEditingController qtyController;
  final TextEditingController purchasePriceController;
  final TextEditingController mrpPriceController;
  final TextEditingController ramController;
  final TextEditingController frontCameraController;
  final TextEditingController backCameraController;
  final TextEditingController displayController;
  final TextEditingController processorController;
  final TextEditingController batteryController;
  final TextEditingController fastChargeController;
  final Function(String?) onBrandSelected;

  const AddStockFields({
    super.key,
    required this.modelController,
    required this.priceController,
    required this.qtyController,
    required this.purchasePriceController,
    required this.mrpPriceController,
    required this.ramController,
    required this.frontCameraController,
    required this.backCameraController,
    required this.displayController,
    required this.processorController,
    required this.batteryController,
    required this.fastChargeController,
    required this.onBrandSelected,
  });

  @override
  State<AddStockFields> createState() => _AddStockFieldsState();
}

class _AddStockFieldsState extends State<AddStockFields> {
  String? selectedBrand;

  // void _refreshBrands() {
  //   setState(() {}); // Force rebuild to fetch latest brands
  // }

  // void _addBrand() {
  //   String newBrand = '';
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Add New Brand'),
  //       content: TextField(
  //         onChanged: (value) => newBrand = value,
  //         decoration: const InputDecoration(hintText: 'Brand name'),
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Cancel')),
  //         ElevatedButton(
  //             onPressed: () {
  //               if (newBrand.trim().isNotEmpty) {
  //                 BrandDb.addBrand(newBrand.trim());
  //                 setState(() {
  //                   selectedBrand = newBrand.trim();
  //                 });
  //                 _refreshBrands();
  //               }
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Add')),
  //       ],
  //     ),
  //   );
  // }

  // void _editBrand(String currentBrand) {
  //   String updatedBrand = currentBrand;

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Edit Brand'),
  //       content: TextFormField(
  //         initialValue: currentBrand,
  //         onChanged: (value) => updatedBrand = value,
  //         decoration: const InputDecoration(hintText: 'New brand name'),
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Cancel')),
  //         ElevatedButton(
  //             onPressed: () {
  //               if (updatedBrand.trim().isNotEmpty) {
  //                 final index = BrandDb.getBrands()
  //                     .indexWhere((brand) => brand.name == currentBrand);
  //                 if (index != -1) {
  //                   BrandDb.updateBrand(index, updatedBrand.trim());
  //                   if (selectedBrand == currentBrand) {
  //                     setState(() {
  //                       selectedBrand = updatedBrand.trim();
  //                     });
  //                   }
  //                   _refreshBrands();
  //                 }
  //               }
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Update')),
  //       ],
  //     ),
  //   );
  // }

  // void _deleteBrand(String brandToDelete) {
  //   final index =
  //       BrandDb.getBrands().indexWhere((b) => b.name == brandToDelete);
  //   if (index == -1) return;

  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Delete Brand?'),
  //       content: Text('Are you sure you want to delete "$brandToDelete"?'),
  //       actions: [
  //         TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Cancel')),
  //         ElevatedButton(
  //             onPressed: () {
  //               BrandDb.deleteBrand(index);
  //               if (selectedBrand == brandToDelete) {
  //                 setState(() {
  //                   selectedBrand = null;
  //                 });
  //               }
  //               _refreshBrands();
  //               Navigator.pop(context);
  //             },
  //             child: const Text('Delete')),
  //       ],
  //     ),
  //   );
  // }

  // Widget _brandManagerMenu() {
  //   return PopupMenuButton<String>(
  //     icon: const Icon(Icons.add),
  //     onSelected: (value) {
  //       if (value == 'add') _addBrand();
  //       if (value == 'edit' && selectedBrand != null) {
  //         _editBrand(selectedBrand!);
  //       }
  //       if (value == 'delete' && selectedBrand != null) {
  //         _deleteBrand(selectedBrand!);
  //       }
  //     },
  //     itemBuilder: (context) => [
  //       const PopupMenuItem(value: 'add', child: Text('Add Brand')),
  //       if (selectedBrand != null)
  //         const PopupMenuItem(value: 'edit', child: Text('Edit Brand')),
  //       if (selectedBrand != null)
  //         const PopupMenuItem(value: 'delete', child: Text('Delete Brand')),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final brands = BrandDb.getBrands();

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF5F6FA),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
    );

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: brands.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        'No brands available. Add a brand to continue.',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : DropdownButtonFormField<String>(
                      value: selectedBrand,
                      hint: const Text('Select Brand'),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      items: brands.map((brand) {
                        return DropdownMenuItem<String>(
                          value: brand.name,
                          child: Text(brand.name),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBrand = newValue;
                          widget.onBrandSelected(newValue);
                        });
                      },
                    ),
            ),
            const SizedBox(width: 8),
            // _brandManagerMenu(),
          ],
        ),
        const SizedBox(height: 16),
        TextField(
          controller: widget.modelController,
          decoration: inputDecoration.copyWith(hintText: 'Enter Model Name'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: widget.mrpPriceController,
          decoration: inputDecoration.copyWith(hintText: 'Enter MRP Price'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: widget.purchasePriceController,
          decoration:
              inputDecoration.copyWith(hintText: 'Enter Purchase Price'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: widget.priceController,
          decoration: inputDecoration.copyWith(hintText: 'Enter Selling Price'),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: widget.qtyController,
          decoration: inputDecoration.copyWith(hintText: 'Enter Qty'),
          keyboardType: TextInputType.number,
        ),
        TextField(
            controller: widget.ramController,
            decoration: inputDecoration.copyWith(hintText: 'RAM')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.frontCameraController,
            decoration: inputDecoration.copyWith(hintText: 'Front Camera')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.backCameraController,
            decoration: inputDecoration.copyWith(hintText: 'Back Camera')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.displayController,
            decoration: inputDecoration.copyWith(hintText: 'Display')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.processorController,
            decoration: inputDecoration.copyWith(hintText: 'Processor')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.batteryController,
            decoration: inputDecoration.copyWith(hintText: 'Battery')),
        const SizedBox(height: 12),
        TextField(
            controller: widget.fastChargeController,
            decoration: inputDecoration.copyWith(hintText: 'Fast Charging')),
      ],
    );
  }
}
