// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GoalsTransactionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalsTransactionModelAdapter extends TypeAdapter<GoalsTransactionModel> {
  @override
  final int typeId = 5;

  @override
  GoalsTransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalsTransactionModel(
      uid: fields[0] as String,
      date: fields[1] as DateTime,
      amount: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, GoalsTransactionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalsTransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
