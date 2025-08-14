import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobilemart/database/models/product_model.dart';
import 'package:mobilemart/database/fuctions/product_db.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_buttons.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_fields.dart';
import 'package:mobilemart/screens/addstock/widget/add_stock_imagepicker.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel product;
  final int productKey;

  const EditProductScreen({
    super.key,
    required this.product,
    required this.productKey,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController modelController;
  late TextEditingController priceController;
  late TextEditingController qtyController;
  late TextEditingController purchasePriceController;
  late TextEditingController mrpPriceController;
  late TextEditingController ramController;
  late TextEditingController frontCameraController;
  late TextEditingController backCameraController;
  late TextEditingController displayController;
  late TextEditingController processorController;
  late TextEditingController batteryController;
  late TextEditingController fastChargeController;

  File? _image;
  String? selectedBrand;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing product data
    modelController = TextEditingController(text: widget.product.modelName);
    priceController = TextEditingController(text: widget.product.price);
    qtyController = TextEditingController(text: widget.product.quantity);
    purchasePriceController =
        TextEditingController(text: widget.product.purchasePrice);
    mrpPriceController = TextEditingController(text: widget.product.mrpPrice);
    ramController = TextEditingController(text: widget.product.ram);
    frontCameraController =
        TextEditingController(text: widget.product.frontCamera);
    backCameraController =
        TextEditingController(text: widget.product.backCamera);
    displayController = TextEditingController(text: widget.product.display);
    processorController = TextEditingController(text: widget.product.processor);
    batteryController = TextEditingController(text: widget.product.battery);
    fastChargeController =
        TextEditingController(text: widget.product.fastCharge);

    _image = File(widget.product.imagePath);
    selectedBrand = widget.product.brand;
  }

  void saveProduct() {
    final model = modelController.text.trim();
    final price = priceController.text.trim();
    final qty = qtyController.text.trim();
    final purchasePrice = purchasePriceController.text.trim();
    final mrpPrice = mrpPriceController.text.trim();
    final ram = ramController.text.trim();
    final frontCamera = frontCameraController.text.trim();
    final backCamera = backCameraController.text.trim();
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
        ram.isEmpty ||
        frontCamera.isEmpty ||
        backCamera.isEmpty ||
        display.isEmpty ||
        processor.isEmpty ||
        battery.isEmpty ||
        fastCharge.isEmpty ||
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
//flutter packages pub run build_runner build --delete-conflicting-outputs

    // Create updated product
    final updatedProduct = ProductModel(
      modelName: model,
      brand: selectedBrand!,
      price: price,
      quantity: qty,
      imagePath: _image!.path,
      purchasePrice: purchasePrice,
      mrpPrice: mrpPrice,
      ram: ram,
      frontCamera: frontCamera,
      backCamera: backCamera,
      display: display,
      processor: processor,
      battery: battery,
      fastCharge: fastCharge,
    );

    // Update the product in the database
    ProductDb.updateProduct(widget.productKey, updatedProduct);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Product updated successfully')),
    );

    // Navigate back to InventoryScreen
    Navigator.pop(context);
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
      appBar: AppBar(title: const Text("Edit Product")),
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
              onCancel: () => Navigator.pop(context),
              onSave: saveProduct,
            ),
          ],
        ),
      ),
    );
  }
}
