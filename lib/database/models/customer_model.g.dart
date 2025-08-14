// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 5;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      customerName: fields[0] as String,
      customerEmail: fields[1] as String,
      customerPhone: fields[2] as String,
      customerAdress: fields[3] as String,
      productNames: (fields[4] as List).cast<String>(),
      imagePaths: (fields[5] as List).cast<String>(),
      quantities: (fields[6] as List).cast<int>(),
      total: fields[7] as int,
      orderDate: fields[8] as DateTime,
      purchasePrices: (fields[9] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.customerName)
      ..writeByte(1)
      ..write(obj.customerEmail)
      ..writeByte(2)
      ..write(obj.customerPhone)
      ..writeByte(3)
      ..write(obj.customerAdress)
      ..writeByte(4)
      ..write(obj.productNames)
      ..writeByte(5)
      ..write(obj.imagePaths)
      ..writeByte(6)
      ..write(obj.quantities)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.orderDate)
      ..writeByte(9)
      ..write(obj.purchasePrices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
