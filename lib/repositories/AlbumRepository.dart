import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/services/ApiService.dart';

class AlbumRepository {
  final ApiService _api;
  AlbumRepository(this._api);

  Future<AlbumModel> fetchAlbumInformation(String albumId) {
    return _api.getAlbumInformation(albumId: albumId);
  }

  Future<AlbumTracksModel> fetchAlbumTracks(String albumId) {
    return _api.fetchAlbumTracks(albumId);
  }
}
