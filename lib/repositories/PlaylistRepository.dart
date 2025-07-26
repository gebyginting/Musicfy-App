import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/services/ApiService.dart';

class Playlistrepository {
  final Apiservice _api = Apiservice();

  Future<PlaylistModel> fetchPlaylistTracks(String playlistId) {
    return _api.getPlaylistTracks(playlistId: playlistId);
  }
}
