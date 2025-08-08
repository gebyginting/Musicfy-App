import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/ApiService.dart';

class ArtistRepository {
  final ApiService _api;
  ArtistRepository(this._api);

  Future<ArtistModel> fetchArtistInformation(String artistId) {
    return _api.getArtistInformation(artistId: artistId);
  }

  Future<List<ArtistModel>> fetchArtistListInformation(List<String> ids) {
    return _api.getArtistListInformation(ids);
  }

  Future<List<AlbumModel>> fetchArtistAlbum(String artistId) {
    return _api.fetchArtistAlbums(artistId);
  }

  Future<List<TrackModel>> fetchArtistTopTracks(String artistId) {
    return _api.fetchArtistTopTracks(artistId);
  }
}
