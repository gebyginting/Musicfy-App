import 'package:flutter/foundation.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/repositories/PlaylistRepository.dart';

class PlaylistViewModel extends ChangeNotifier {
  final PlaylistRepository _repository;

  PlaylistViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<PlaylistModel> _playlists = [];
  List<PlaylistModel> get playlists => _playlists;

  Future<void> loadPlaylists(List<String> playlistIds) async {
    _setLoading(true);
    try {
      _playlists = await Future.wait(
        playlistIds.map(_repository.fetchPlaylistTracks),
      );
    } catch (e) {
      _setError('Failed to load playlists: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _error = value;
    notifyListeners();
  }
}
