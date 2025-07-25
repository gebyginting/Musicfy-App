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
    return TrackModel(
      id: json['id'],
      name: json['name'],
      artist: (json['artists'] as List).map((a) => a['name']).join(', '),
      albumImage: json['album']['images'][0]['url'], // ambil resolusi terbesar
      albumName: json['album']['name'],
      durationMs: json['duration_ms'],
    );
  }
}
