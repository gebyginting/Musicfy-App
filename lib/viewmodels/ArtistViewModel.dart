import 'package:flutter/foundation.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/repositories/ArtistRepository.dart';

class ArtistViewModel extends ChangeNotifier {
  final ArtistRepository _repository;

  ArtistViewModel(this._repository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  ArtistModel? _artist;
  ArtistModel? get artist => _artist;

  List<AlbumModel> _albums = [];
  List<AlbumModel> get albums => _albums;

  List<TrackModel> _topTracks = [];
  List<TrackModel> get topTracks => _topTracks;

  List<ArtistModel> _artistList = [];
  List<ArtistModel> get artistList => _artistList;

  int get totalAlbums => _albums.length;

  Future<void> loadArtist(String artistId) async {
    _setLoading(true);
    try {
      _artist = await _repository.fetchArtistInformation(artistId);
      _albums = await _repository.fetchArtistAlbum(artistId);
      _topTracks = await _repository.fetchArtistTopTracks(artistId);
    } catch (e) {
      _setError('Failed to load artist: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadArtists(List<String> ids) async {
    _setLoading(true);
    try {
      _artistList = await _repository.fetchArtistListInformation(ids);
    } catch (e) {
      _setError('Failed to load artist list: $e');
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
