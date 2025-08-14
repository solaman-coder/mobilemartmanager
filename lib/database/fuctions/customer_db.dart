import 'package:hive/hive.dart';
import 'package:mobilemart/database/models/customer_model.dart';

class CoustomerDb {
  static final _box = Hive.box<CustomerModel>('customer');

  static Future<void> saveUserCheckout(CustomerModel model) async {
    await _box.add(model);
  }

  static List<CustomerModel> getAllCheckouts() {
    return _box.values.toList();
  }
}
