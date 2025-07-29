// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackModelAdapter extends TypeAdapter<TrackModel> {
  @override
  final int typeId = 0;

  @override
  TrackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackModel(
      id: fields[0] as String,
      name: fields[1] as String,
      artist: fields[2] as String,
      albumImage: fields[3] as String,
      albumName: fields[4] as String,
      durationMs: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TrackModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.artist)
      ..writeByte(3)
      ..write(obj.albumImage)
      ..writeByte(4)
      ..write(obj.albumName)
      ..writeByte(5)
      ..write(obj.durationMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
