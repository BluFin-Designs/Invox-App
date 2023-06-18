// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transaction_Model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelAdapter extends TypeAdapter<TransactionModel> {
  @override
  final int typeId = 1;

  @override
  TransactionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModel(
      uid: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      amount: fields[3] as double?,
      icons: fields[4] as int,
      date: fields[5] as DateTime?,
      category: fields[6] as TransactionCategoryModel,
      txnType: fields[7] as TransactionType?,
      wallet: fields[8] as Wallet?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.icons)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.category)
      ..writeByte(7)
      ..write(obj.txnType)
      ..writeByte(8)
      ..write(obj.wallet);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final int typeId = 3;

  @override
  TransactionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionType.CREDIT;
      case 1:
        return TransactionType.DEBIT;
      default:
        return TransactionType.CREDIT;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    switch (obj) {
      case TransactionType.CREDIT:
        writer.writeByte(0);
        break;
      case TransactionType.DEBIT:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
