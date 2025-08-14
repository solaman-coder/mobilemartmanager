import 'package:hive/hive.dart';
part 'brand_model.g.dart';

@HiveType(typeId: 2)
class BrandModel {
  @HiveField(0)
  final String name;
  BrandModel({required this.name});
}
