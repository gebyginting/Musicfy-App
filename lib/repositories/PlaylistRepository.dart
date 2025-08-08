import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/services/ApiService.dart';

class PlaylistRepository {
  final ApiService _api;

  PlaylistRepository(this._api);

  Future<PlaylistModel> fetchPlaylistTracks(String playlistId) {
    return _api.getPlaylistTracks(playlistId: playlistId);
  }
}
