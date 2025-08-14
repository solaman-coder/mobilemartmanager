import 'dart:io';
import 'package:flutter/material.dart';

// import 'package:image_picker/image_picker.dart';

import 'package:mobilemart/routes/app_routes.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_buttons.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_fields.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_imagepicker.dart';

import '../../database/fuctions/product_db.dart';
import '../../database/fuctions/product_purchase_db.dart';
import '../../database/models/product_purchase_model.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final mrpPriceController = TextEditingController();
  final ramController = TextEditingController();
  final frontCameraController = TextEditingController();
  final backCameraController = TextEditingController();
  final displayController = TextEditingController();
  final processorController = TextEditingController();
  final batteryController = TextEditingController();
  final fastChargeController = TextEditingController();

  File? _image;
  String? selectedBrand;

  void saveProduct() async {
    final model = modelController.text.trim();
    final price = priceController.text.trim();
    final qty = qtyController.text.trim();
    final purchasePrice = purchasePriceController.text.trim();
    final mrpPrice = mrpPriceController.text.trim();
    final ram = ramController.text.trim();
    final frontCam = frontCameraController.text.trim();
    final backCam = backCameraController.text.trim();
    final display = displayController.text.trim();
    final processor = processorController.text.trim();
    final battery = batteryController.text.trim();
    final fastCharge = fastChargeController.text.trim();

    // Validate inputs
    if (model.isEmpty ||
        price.isEmpty ||
        qty.isEmpty ||
        purchasePrice.isEmpty ||
        mrpPrice.isEmpty ||
        _image == null ||
        selectedBrand == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please fill all fields and select an image and brand')),
      );
      return;
    }

    // Validate numeric fields
    if (double.tryParse(price) == null ||
        double.tryParse(purchasePrice) == null ||
        double.tryParse(mrpPrice) == null ||
        int.tryParse(qty) == null ||
        int.parse(qty) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Please enter valid numeric values for prices and quantity')),
      );
      return;
    }

    // Use the shared method to add or update the product
    ProductDb.addOrUpdateProduct(
        modelName: model,
        brand: selectedBrand!,
        price: price,
        quantity: qty,
        imagePath: _image!.path,
        purchasePrice: purchasePrice,
        mrpPrice: mrpPrice,
        ram: ram,
        frontCamera: frontCam,
        backCamera: backCam,
        display: display,
        processor: processor,
        battery: battery,
        fastCharge: fastCharge); // 🔹 Save Purchase Info
    await ProductPurchaseDb.addPurchase(
      ProductPurchaseModel(
        modelName: model,
        brand: selectedBrand!,
        quantity: int.parse(qty),
        purchasePrice: int.parse(purchasePrice),
        date: DateTime.now(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product added successfully')),
    );

    // Navigate back to inventory
    Navigator.pushReplacementNamed(context, AppRoutes.inventory);
  }

  @override
  void dispose() {
    modelController.dispose();
    priceController.dispose();
    qtyController.dispose();
    purchasePriceController.dispose();
    mrpPriceController.dispose();
    ramController.dispose();
    frontCameraController.dispose();
    backCameraController.dispose();
    displayController.dispose();
    processorController.dispose();
    batteryController.dispose();
    fastChargeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddStockImagePicker(
              onImageSelected: (pickedImage) {
                setState(() => _image = pickedImage);
              },
            ),
            const SizedBox(height: 12),
            AddStockFields(
              modelController: modelController,
              priceController: priceController,
              qtyController: qtyController,
              purchasePriceController: purchasePriceController,
              mrpPriceController: mrpPriceController,
              ramController: ramController,
              frontCameraController: frontCameraController,
              backCameraController: backCameraController,
              displayController: displayController,
              processorController: processorController,
              batteryController: batteryController,
              fastChargeController: fastChargeController,
              onBrandSelected: (brand) {
                setState(() {
                  selectedBrand = brand;
                });
              },
            ),
            const SizedBox(height: 20),
            AddStockButtons(
              onCancel: () =>
                  Navigator.pushReplacementNamed(context, AppRoutes.inventory),
              onSave: saveProduct,
            ),
          ],
        ),
      ),
    );
  }
}
