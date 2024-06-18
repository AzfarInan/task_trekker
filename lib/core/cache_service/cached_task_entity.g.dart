// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_task_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedTaskEntityAdapter extends TypeAdapter<CachedTaskEntity> {
  @override
  final int typeId = 0;

  @override
  CachedTaskEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedTaskEntity(
      taskId: fields[0] as String,
      taskActivationTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedTaskEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.taskId)
      ..writeByte(1)
      ..write(obj.taskActivationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedTaskEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
