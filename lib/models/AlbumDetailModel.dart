import 'package:my_spotify/models/track_model.dart';

class AlbumTracksModel {
  final int limit;
  final List<TrackModel> items;

  AlbumTracksModel({required this.limit, required this.items});

  factory AlbumTracksModel.fromJson(Map<String, dynamic> json) {
    return AlbumTracksModel(
      limit: json['limit'],

      items: List<TrackModel>.from(
        json['items'].map((item) => TrackModel.fromJson(item)),
      ),
    );
  }
}
