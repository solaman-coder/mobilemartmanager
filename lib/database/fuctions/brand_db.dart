import 'package:hive/hive.dart';
import 'package:mobilemart/database/fuctions/product_db.dart';

import '../models/brand_model.dart';

class BrandDb {
  static final _brandBox = Hive.box<BrandModel>('brands');
  static List<BrandModel> getBrands() {
    return _brandBox.values.toList();
  }

  static Future<void> addBrand(String name) async {
    await _brandBox.add(BrandModel(name: name));
    await ProductDb.enableProductsByBrand(name);
  }

  static void updateBrand(int index, String newName) {
    _brandBox.putAt(index, BrandModel(name: newName));
  }

  static Future<void> deleteBrand(dynamic key) async {
    await _brandBox.delete(key);
  }

  static Box<BrandModel> getBrandBox() {
    return _brandBox;
  }
}
