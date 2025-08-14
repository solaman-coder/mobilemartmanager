// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_purchase_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductPurchaseModelAdapter extends TypeAdapter<ProductPurchaseModel> {
  @override
  final int typeId = 6;

  @override
  ProductPurchaseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductPurchaseModel(
      modelName: fields[0] as String,
      brand: fields[1] as String,
      quantity: fields[2] as int,
      purchasePrice: fields[3] as int,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductPurchaseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.modelName)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.purchasePrice)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPurchaseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
