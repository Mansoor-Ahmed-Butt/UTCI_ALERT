// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'utci_status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UtciStatusModelAdapter extends TypeAdapter<UtciStatusModel> {
  @override
  final int typeId = 1;

  @override
  UtciStatusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UtciStatusModel(
      category: fields[0] as String,
      value: fields[1] as double,
      city: fields[2] as String,
      updatedAt: fields[3] as DateTime,
      suggestion: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UtciStatusModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.updatedAt)
      ..writeByte(4)
      ..write(obj.suggestion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UtciStatusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
