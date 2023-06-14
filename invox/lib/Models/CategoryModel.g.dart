// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionCategoryModelAdapter
    extends TypeAdapter<TransactionCategoryModel> {
  @override
  final int typeId = 2;

  @override
  TransactionCategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionCategoryModel(
      title: fields[3] as String,
      color: fields[2] as int,
      icon: fields[1] as int,
      Uid: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionCategoryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.Uid)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionCategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
