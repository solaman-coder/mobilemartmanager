import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilemart/database/models/cart_item_model.dart';
import 'package:mobilemart/database/models/customer_model.dart';
import 'package:mobilemart/database/models/expence_model.dart';
import 'package:mobilemart/database/models/product_model.dart';
import 'package:mobilemart/database/models/product_purchase_model.dart';
import 'package:mobilemart/database/models/usermodels.dart';

import '../database/models/brand_model.dart';
import '../database/models/profile_model.dart';

Future<bool> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(ProfileModelAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(ProductPurchaseModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  var userBox = await Hive.openBox<UserModel>('userBox');
  await Hive.openBox<ProductModel>('products');
  await Hive.openBox<BrandModel>('brands');
  await Hive.openBox<ProfileModel>('profileBox');
  await Hive.openBox<CartItemModel>('cart');
  await Hive.openBox<CustomerModel>('customer');
  await Hive.openBox('statusBox');
  await Hive.openBox<ProductPurchaseModel>('product_purchases');
  await Hive.openBox<ExpenseModel>('expenses');
  return userBox.get('user') != null;
}
