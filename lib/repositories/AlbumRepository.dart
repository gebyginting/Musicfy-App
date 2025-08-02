import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/services/ApiService.dart';

class AlbumRepository {
  final Apiservice _api = Apiservice();

  Future<AlbumTracksModel> fetchAlbumTracks(String albumId) {
    return _api.fetchAlbumTracks(albumId);
  }
}
