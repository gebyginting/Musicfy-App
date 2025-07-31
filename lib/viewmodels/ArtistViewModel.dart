import 'package:flutter/material.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/repositories/ArtistRepository.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository repository;

  bool isLoading = false;
  String? error;
  ArtistModel? artist;
  List<AlbumModel> albums = [];
  List<TrackModel> topTracks = [];
  String? totalAlbum;
  ArtistViewModel(this.repository);

  Future<void> loadArtistInformation(String artistId) async {
    isLoading = true;
    error = null;
    albums = [];
    topTracks = [];
    notifyListeners();

    try {
      artist = await repository.fetchArtistInformation(artistId);
      albums = await repository.fetchArtistAlbum(artistId);
      totalAlbum = albums.length.toString();
      topTracks = await repository.fetchArtistTopTracks(artistId);
    } catch (e) {
      error = e.toString();
      debugPrint("Error loading artist: $error");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
