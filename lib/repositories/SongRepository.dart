import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/ApiService.dart';

class Songrepository {
  final Apiservice _api = Apiservice();

  Future<List<TrackModel>> fetchTracks(List<String> ids) async {
    final response = await _api.getTracks(ids);

    final List<dynamic> data = response.data['tracks'];
    return data.map((json) => TrackModel.fromJson(json)).toList();
  }

  // Favorites
  List<TrackModel> getAllFavorites() {
    final box = Hive.box<TrackModel>('favorites');
    return box.values.toList();
  }

  Future<void> addToFavorites(TrackModel track) async {
    final box = Hive.box<TrackModel>('favorites');
    await box.put(track.id, track);
  }

  Future<void> removeFromFavorites(String trackId) async {
    final box = Hive.box<TrackModel>('favorites');
    await box.delete(trackId);
  }

  bool isFavorite(String trackId) {
    final box = Hive.box<TrackModel>('favorites');
    return box.containsKey(trackId);
  }
}
