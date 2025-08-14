import 'package:hive/hive.dart';

import '../models/usermodels.dart';

class UserDb {
  static final _userBox = Hive.box<UserModel>('userBox'); //userBox
  static UserModel? getUser() {
    return _userBox.get('user');
  }

  static Future<void> setLoggedIn(bool status) async {
    final box = Hive.box('statusBox');
    await box.put('loggedIn', status);
  }

  // static void addUser(UserModel user) {
  //   _userBox.put('user', user);
  // }

  static void saveUser(String email, String password) {
    final user = UserModel(email: email, password: password);
    _userBox.put('user', user);
  }

  static bool validateUser(String email, String password) {
    final user = getUser();
    if (user != null) {
      // print(
      //     'eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee Email: ${user.email}, Password: ${user.password}');
    }
    return user != null && user.email == email && user.password == password;
  }

  static Future<void> updatePassword(String newPassword) async {
    final box = Hive.box<UserModel>('userBox'); //userBox
    final user = box.get('user');
    if (user != null) {
      final updatedUser = UserModel(email: user.email, password: newPassword);
      await box.put('user', updatedUser);
    }
  }

  static bool checkCurrentPassword(String currentPassword) {
    final user = getUser();
    return user != null && user.password == currentPassword;
  }

  static bool isLoggedIn() {
    final box = Hive.box('statusBox');
    return box.get('loggedIn', defaultValue: false);
  }
}
