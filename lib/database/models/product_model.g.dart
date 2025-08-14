// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      modelName: fields[0] as String,
      price: fields[1] as String,
      quantity: fields[2] as String,
      imagePath: fields[3] as String,
      brand: fields[4] as String,
      purchasePrice: fields[5] as String,
      mrpPrice: fields[6] as String,
      ram: fields[7] as String,
      frontCamera: fields[8] as String,
      backCamera: fields[9] as String,
      display: fields[10] as String,
      processor: fields[11] as String,
      battery: fields[12] as String,
      fastCharge: fields[13] as String,
      isActive: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.modelName)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.imagePath)
      ..writeByte(4)
      ..write(obj.brand)
      ..writeByte(5)
      ..write(obj.purchasePrice)
      ..writeByte(6)
      ..write(obj.mrpPrice)
      ..writeByte(7)
      ..write(obj.ram)
      ..writeByte(8)
      ..write(obj.frontCamera)
      ..writeByte(9)
      ..write(obj.backCamera)
      ..writeByte(10)
      ..write(obj.display)
      ..writeByte(11)
      ..write(obj.processor)
      ..writeByte(12)
      ..write(obj.battery)
      ..writeByte(13)
      ..write(obj.fastCharge)
      ..writeByte(14)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
