class ArtistModel {
  final String id;
  final String name;
  final int popularity;
  final String uri;
  final String type;
  final String href;
  final String spotifyUrl;
  final int followers;
  final List<String> genres;
  final String imageUrl;

  ArtistModel({
    required this.id,
    required this.name,
    required this.popularity,
    required this.uri,
    required this.type,
    required this.href,
    required this.spotifyUrl,
    required this.followers,
    required this.genres,
    required this.imageUrl,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List? ?? [];
    final firstImageUrl = images.isNotEmpty ? images.first['url'] ?? '' : '';

    return ArtistModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      popularity: json['popularity'] ?? 0,
      uri: json['uri'] ?? '',
      type: json['type'] ?? '',
      href: json['href'] ?? '',
      spotifyUrl: json['external_urls']?['spotify'] ?? '',
      followers: json['followers']?['total'] ?? 0,
      genres: List<String>.from(json['genres'] ?? []),
      imageUrl: firstImageUrl,
    );
  }
}
