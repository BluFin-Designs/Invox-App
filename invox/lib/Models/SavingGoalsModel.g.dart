// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SavingGoalsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingGoalsModelAdapter extends TypeAdapter<SavingGoalsModel> {
  @override
  final int typeId = 4;

  @override
  SavingGoalsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavingGoalsModel(
      uid: fields[0] as String,
      title: fields[1] as String,
      txn: (fields[2] as List).cast<GoalsTransactionModel>(),
      requiredAmount: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, SavingGoalsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.txn)
      ..writeByte(3)
      ..write(obj.requiredAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingGoalsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
