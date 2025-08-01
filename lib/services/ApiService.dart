import 'package:dio/dio.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/SpotifyAuthService.dart';

class Apiservice {
  final Dio _dio = Dio();

  // FETCH TRACKS
  Future<Response> getTracks(List<String> ids) async {
    final token = await Spotifyauthservice().getValidToken();

    return _dio.get(
      'https://api.spotify.com/v1/tracks',
      queryParameters: {'ids': ids.join(','), 'market': 'ES'},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  // FETCH PLAYLIST
  Future<PlaylistModel> getPlaylistTracks({required String playlistId}) async {
    final token = await Spotifyauthservice().getValidToken();

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/playlists/$playlistId',
        queryParameters: {
          'fields':
              'name,owner(display_name),images,tracks.items(added_by.id,track(name,href,album(name,href,images),artists))',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return PlaylistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load playlist tracks: $e');
    }
  }

  // FETCH ARTIST INFORMATION
  Future<ArtistModel> getArtistInformation({required String artistId}) async {
    final token = await Spotifyauthservice().getValidToken();

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return ArtistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load artists information: $e');
    }
  }

  // FETCH ARTIST LIST INFORMATION
  Future<List<ArtistModel>> getArtistListInformation(List<String> ids) async {
    final token = await Spotifyauthservice().getValidToken();

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists',
        queryParameters: {'ids': ids.join(','), 'market': 'ES'},

        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final data = response.data;
      final items = data['artists'] as List;

      return items.map((item) => ArtistModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artists information: $e');
    }
  }

  // FETCH ARTIST ALBUM INFORMATION
  Future<List<AlbumModel>> fetchArtistAlbum(String artistId) async {
    final token = await Spotifyauthservice().getValidToken();

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId/albums',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'include_groups': 'single,appears_on', 'limit': 10},
      );

      final data = response.data;
      final items = data['items'] as List;

      return items.map((item) => AlbumModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artist albums: $e');
    }
  }

  // FETCH ARTIST TOP TRACKS
  Future<List<TrackModel>> fetchArtistTopTracks(String artistId) async {
    final token = await Spotifyauthservice().getValidToken();

    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId/top-tracks',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        queryParameters: {'market': 'ES'},
      );

      final data = response.data;
      final items = data['tracks'] as List;

      return items.map((item) => TrackModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artist top tracks: $e');
    }
  }
}
