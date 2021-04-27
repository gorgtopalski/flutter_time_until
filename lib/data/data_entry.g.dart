// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DateEntryAdapter extends TypeAdapter<DateEntry> {
  @override
  final int typeId = 0;

  @override
  DateEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DateEntry(
      fields[1] as String?,
      fields[0] as DateTime,
    )..icon = fields[2] as IconData?;
  }

  @override
  void write(BinaryWriter writer, DateEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
