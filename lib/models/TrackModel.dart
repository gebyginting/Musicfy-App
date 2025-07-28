class TrackModel {
  final String id;
  final String name;
  final String artist;
  final String albumImage;
  final String albumName;
  final int durationMs;

  TrackModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.albumImage,
    required this.albumName,
    required this.durationMs,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    final artistsJson = json['artists'] as List?;
    final artistNames =
        artistsJson != null
            ? artistsJson.map((a) => a['name'] ?? 'Unknown').join(', ')
            : 'Unknown Artist';

    final albumImages = (json['album']?['images'] as List?) ?? [];
    final albumImageUrl =
        albumImages.isNotEmpty ? albumImages[0]['url'] ?? '' : '';

    return TrackModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      artist: artistNames,
      albumImage: albumImageUrl,
      albumName: json['album']?['name'] ?? 'Unknown Album',
      durationMs: json['duration_ms'] ?? 0,
    );
  }
}
