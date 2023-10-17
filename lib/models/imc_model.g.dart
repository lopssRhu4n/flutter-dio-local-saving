// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCModelAdapter extends TypeAdapter<IMCModel> {
  @override
  final int typeId = 0;

  @override
  IMCModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCModel()
      ..name = fields[0] as String
      ..height = fields[1] as double
      ..weight = fields[2] as double
      ..imc = fields[3] as double
      ..classification = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, IMCModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.imc)
      ..writeByte(4)
      ..write(obj.classification);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
