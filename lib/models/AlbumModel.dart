class AlbumModel {
  final String id;
  final String name;
  final String releaseDate;
  final String albumType;
  final String? albumGroup;
  final int totalTracks;
  final String imageUrl;
  final String artistName;
  final String spotifyUrl;

  AlbumModel({
    required this.id,
    required this.name,
    required this.releaseDate,
    required this.albumType,
    required this.totalTracks,
    required this.imageUrl,
    required this.artistName,
    required this.spotifyUrl,
    this.albumGroup,
  });

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    final images = json['images'] as List? ?? [];
    final firstImageUrl = images.isNotEmpty ? images.first['url'] ?? '' : '';

    final artists = json['artists'] as List? ?? [];
    final firstArtistUrl =
        artists.isNotEmpty ? artists.first['name'] ?? '' : '';

    return AlbumModel(
      id: json['id'],
      name: json['name'],
      releaseDate: json['release_date'],
      albumType: json['album_type'],
      albumGroup: json['album_group'],
      totalTracks: json['total_tracks'],
      imageUrl: firstImageUrl,
      artistName: firstArtistUrl,

      spotifyUrl: json['external_urls']['spotify'],
    );
  }
}
