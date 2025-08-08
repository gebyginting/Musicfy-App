import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/ApiService.dart';

class SongRepository {
  final ApiService _api;

  SongRepository(this._api);

  Future<List<TrackModel>> fetchTracks(List<String> ids) {
    return _api.getTracks(ids); // Sudah return TrackModel list
  }

  // Favorites section (optional: pisahkan ke FavoritesRepository)
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
