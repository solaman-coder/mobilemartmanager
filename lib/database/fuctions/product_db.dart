import 'package:hive/hive.dart';

import '../models/product_model.dart';

class ProductDb {
  static final _productBox = Hive.box<ProductModel>('products');

  static List<ProductModel> getAll() => _productBox.values.toList();

  static void addProduct(ProductModel product) {
    _productBox.add(product);
  }

  static void updateQuantity(int productKey, int newQuantity) {
    final product = _productBox.getAt(productKey);
    if (product != null) {
      final updatedProduct = ProductModel(
        modelName: product.modelName,
        price: product.price,
        quantity: newQuantity.toString(),
        imagePath: product.imagePath,
        brand: product.brand,
        purchasePrice: product.purchasePrice,
        mrpPrice: product.mrpPrice,
        ram: product.ram,
        frontCamera: product.frontCamera,
        backCamera: product.backCamera,
        display: product.display,
        processor: product.processor,
        battery: product.battery,
        fastCharge: product.fastCharge,
      );
      _productBox.putAt(productKey, updatedProduct);
    }
  }

  static void addOrUpdateProduct({
    required String modelName,
    required String brand,
    required String price,
    required String quantity,
    required String imagePath,
    required String purchasePrice,
    required String mrpPrice,
    required String ram,
    required String frontCamera,
    required String backCamera,
    required String display,
    required String processor,
    required String battery,
    required String fastCharge,
  }) {
    final products = getAll();
    final existingProductIndex = products.indexWhere(
      (p) => p.modelName == modelName && p.brand == brand,
    );

    if (existingProductIndex != -1) {
      // Product exists, update quantity
      final product = products[existingProductIndex];
      final currentQuantity = int.parse(product.quantity);
      final newQuantity = currentQuantity + int.parse(quantity);
      updateQuantity(existingProductIndex, newQuantity);
    } else {
      // Product doesn't exist, add new
      final newProduct = ProductModel(
        modelName: modelName,
        price: price,
        quantity: quantity,
        imagePath: imagePath,
        brand: brand,
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
      addProduct(newProduct);
    }
  }

  static void deleteProduct(int productKey) {
    _productBox.deleteAt(productKey);
  }

  static void updateProduct(int productKey, ProductModel updatedProduct) {
    _productBox.putAt(productKey, updatedProduct);
  }

  static ProductModel? getByKey(int key) {
    try {
      return _productBox.getAt(key);
    } catch (e) {
      return null;
    }
  }

  static Future<void> disableProductsByBrand(String brandName) async {
    final productBox = Hive.box<ProductModel>('products');
    for (var key in productBox.keys) {
      final product = productBox.get(key);
      if (product != null &&
          product.brand.toLowerCase() == brandName.toLowerCase()) {
        final updatedProduct = ProductModel(
          modelName: product.modelName,
          price: product.price,
          quantity: product.quantity,
          imagePath: product.imagePath,
          brand: product.brand,
          purchasePrice: product.purchasePrice,
          mrpPrice: product.mrpPrice,
          ram: product.ram,
          frontCamera: product.frontCamera,
          backCamera: product.backCamera,
          display: product.display,
          processor: product.processor,
          battery: product.battery,
          fastCharge: product.fastCharge,
          isActive: false, // <-- Correctly disable here
        );

        await productBox.put(key, updatedProduct);
      }
    }
  }

  static Future<void> enableProductsByBrand(String brandName) async {
    final productBox = Hive.box<ProductModel>('products');
    for (var key in productBox.keys) {
      final product = productBox.get(key);
      if (product != null &&
          product.brand.toLowerCase() == brandName.toLowerCase() &&
          product.isActive == false) {
        final updatedProduct = ProductModel(
          modelName: product.modelName,
          price: product.price,
          quantity: product.quantity,
          imagePath: product.imagePath,
          brand: product.brand,
          purchasePrice: product.purchasePrice,
          mrpPrice: product.mrpPrice,
          ram: product.ram,
          frontCamera: product.frontCamera,
          backCamera: product.backCamera,
          display: product.display,
          processor: product.processor,
          battery: product.battery,
          fastCharge: product.fastCharge,
          isActive: true, // ✅ Reactivate product
        );
        await productBox.put(key, updatedProduct);
      }
    }
  }

  // static List<ProductModel> getByBrand(String brand) {
  //   return _productBox.values
  //       .where((product) => product.brand == brand)
  //       .toList();
  // }
}
