import 'package:flutter/material.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/repositories/PlaylistRepository.dart';

class Playlistviewmodel extends ChangeNotifier {
  final Playlistrepository repository;

  List<PlaylistModel> playlists = [];
  bool isLoading = false;
  String? error;

  Playlistviewmodel(this.repository);

  Future<void> loadMultiplePlaylists(List<String> playlistIds) async {
    isLoading = true;
    error = null;
    playlists = [];
    notifyListeners();

    try {
      final futures = playlistIds.map(
        (id) => repository.fetchPlaylistTracks(id),
      );
      playlists = await Future.wait(futures);
    } catch (e) {
      error = e.toString();
      debugPrint("Error loading playlist: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
