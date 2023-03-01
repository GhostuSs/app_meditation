// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 1;

  @override
  UserData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserData(
      name: fields[0] as String?,
      choose: (fields[2] as List?)?.cast<String>(),
      phone: fields[1] as String?,
      mail: fields[3] as String?,
      authcompleted: fields[6] as bool?,
      firstActivation: fields[4] as bool?,
      onbpassed: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone)
      ..writeByte(2)
      ..write(obj.choose)
      ..writeByte(3)
      ..write(obj.mail)
      ..writeByte(4)
      ..write(obj.firstActivation)
      ..writeByte(5)
      ..write(obj.onbpassed)
      ..writeByte(6)
      ..write(obj.authcompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
