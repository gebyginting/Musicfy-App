import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/ApiService.dart';

class ArtistRepository {
  final Apiservice _api = Apiservice();

  Future<ArtistModel> fetchArtistInformation(String artistId) {
    return _api.getArtistInformation(artistId: artistId);
  }

  Future<List<AlbumModel>> fetchArtistAlbum(String artistId) {
    return _api.fetchArtistAlbum(artistId);
  }

  Future<List<TrackModel>> fetchArtistTopTracks(String artistId) {
    return _api.fetchArtistTopTracks(artistId);
  }
}
