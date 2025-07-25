import 'package:flutter/material.dart';
import 'package:my_spotify/models/TrackModel.dart';
import 'package:my_spotify/repositories/SongRepository.dart';

class SongViewModel extends ChangeNotifier {
  final Songrepository _repository;

  SongViewModel(this._repository); // Inject repository lewat constructor

  List<TrackModel> _songs = [];
  List<TrackModel> get songs => _songs;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadSongsByIds(List<String> ids) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _songs = await _repository.fetchTracks(ids);
    } catch (e) {
      _errorMessage = 'Failed to load songs: $e';
      debugPrint(_errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
