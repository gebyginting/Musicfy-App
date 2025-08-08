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
      artists: (fields[2] as List).cast<Artist>(),
      albumId: fields[3] as String,
      albumImage: fields[4] as String,
      albumName: fields[5] as String,
      durationMs: fields[6] as int,
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
      ..write(obj.artists)
      ..writeByte(3)
      ..write(obj.albumId)
      ..writeByte(4)
      ..write(obj.albumImage)
      ..writeByte(5)
      ..write(obj.albumName)
      ..writeByte(6)
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

class ArtistAdapter extends TypeAdapter<Artist> {
  @override
  final int typeId = 1;

  @override
  Artist read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Artist(id: fields[0] as String, name: fields[1] as String);
  }

  @override
  void write(BinaryWriter writer, Artist obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArtistAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
