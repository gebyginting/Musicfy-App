import 'package:flutter/foundation.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/repositories/SongRepository.dart';

class SongViewModel extends ChangeNotifier {
  final SongRepository _repository;

  SongViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<TrackModel> _songs = [];
  List<TrackModel> get songs => _songs;

  List<TrackModel> get favorites => _repository.getAllFavorites();

  Future<void> loadSongsByIds(List<String> ids) async {
    _setLoading(true);
    try {
      _songs = await _repository.fetchTracks(ids);
      _error = null;
    } catch (e) {
      _setError('Failed to load songs: $e');
    } finally {
      _setLoading(false);
    }
  }

  void toggleFavorite(TrackModel track) {
    if (_repository.isFavorite(track.id)) {
      _repository.removeFromFavorites(track.id);
    } else {
      _repository.addToFavorites(track);
    }
    notifyListeners();
  }

  bool isFavorite(String id) => _repository.isFavorite(id);

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }
}
