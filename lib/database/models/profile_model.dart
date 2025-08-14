import 'package:hive/hive.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 3)
class ProfileModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String image;
  @HiveField(3)
  final String shopName;

  ProfileModel({
    required this.name,
    required this.phone,
    required this.image,
    required this.shopName,
  });
}
