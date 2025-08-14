import 'package:hive/hive.dart';
import 'package:mobilemart/database/models/profile_model.dart';

class ProfileDb {
  static final _profileBox = Hive.box<ProfileModel>('profileBox');

  // Get user profile data (name, phone, image)
  static ProfileModel? getProfile() {
    return _profileBox.get('user_profile');
    // Returns the first profile
  }

  // Save profile details (name, phone, image)
  static Future<void> saveProfile(ProfileModel profile) async {
    await _profileBox.put(
        'user_profile', profile); // Save profile data to the first position
  }

  // Update the profile details (name, phone, image)
  static Future<void> updateProfile(ProfileModel profile) async {
    await _profileBox.put(
        'user_profile', profile); // Update profile details in ProfileDb
  }
}
