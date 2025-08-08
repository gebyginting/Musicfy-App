import 'package:hive/hive.dart';
part 'track_model.g.dart'; // Wajib

@HiveType(typeId: 0)
class TrackModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<Artist> artists;

  @HiveField(3)
  final String albumId;

  @HiveField(4)
  final String albumImage;

  @HiveField(5)
  final String albumName;

  @HiveField(6)
  final int durationMs;

  TrackModel({
    required this.id,
    required this.name,
    required this.artists,
    required this.albumId,
    required this.albumImage,
    required this.albumName,
    required this.durationMs,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    final artistsJson = json['artists'] as List?;
    final artistList =
        (json['artists'] as List? ?? [])
            .map((a) => Artist.fromJson(a))
            .toList();
    final albumImages = (json['album']?['images'] as List?) ?? [];
    final albumImageUrl =
        albumImages.isNotEmpty ? albumImages[0]['url'] ?? '' : '';

    return TrackModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      artists: artistList,
      albumId: json['album']?['id'] ?? 'Unknown ID',
      albumImage: albumImageUrl,
      albumName: json['album']?['name'] ?? 'Unknown Album',
      durationMs: json['duration_ms'] ?? 0,
    );
  }
}

@HiveType(typeId: 1)
class Artist {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  Artist({required this.id, required this.name});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(id: json['id'] ?? '', name: json['name'] ?? '');
  }
}
