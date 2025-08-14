import 'package:hive/hive.dart';
part 'usermodels.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String password;

  UserModel({
    required this.email,
    required this.password,
   
  });
}
