// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppUserModelAdapter extends TypeAdapter<AppUserModel> {
  @override
  final int typeId = 0;

  @override
  AppUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppUserModel(
      uid: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      roleKey: fields[4] as String,
      photoUrl: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AppUserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.photoUrl)
      ..writeByte(4)
      ..write(obj.roleKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
