class Song {
  final int id;
  final String title;
  final String artist;
  final String url;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.url,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      url: json['url'],
    );
  }
}
