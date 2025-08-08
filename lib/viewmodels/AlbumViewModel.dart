import 'package:flutter/material.dart';
import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/repositories/AlbumRepository.dart';

class AlbumViewModel extends ChangeNotifier {
  final AlbumRepository _repository;

  AlbumViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  AlbumModel? _albumInfo;
  AlbumModel? get albumInfo => _albumInfo;

  AlbumTracksModel? _albumTracks;
  AlbumTracksModel? get albumTracks => _albumTracks;

  Future<void> loadAlbum(String albumId) async {
    _setLoading(true);
    try {
      _albumInfo = await _repository.fetchAlbumInformation(albumId);
      _albumTracks = await _repository.fetchAlbumTracks(albumId);
    } catch (e) {
      _setError('Failed to load album: $e');
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
