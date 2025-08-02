import 'package:flutter/material.dart';
import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/repositories/AlbumRepository.dart';

class AlbumViewModel extends ChangeNotifier {
  final AlbumRepository repository;

  bool isLoading = false;
  String? error;
  AlbumTracksModel? album;
  AlbumViewModel(this.repository);

  Future<void> loadAlbumTracks(String albumId) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      album = await repository.fetchAlbumTracks(albumId);
    } catch (e) {
      error = e.toString();
      debugPrint("Error loading artist: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
