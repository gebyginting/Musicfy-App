import 'package:dio/dio.dart';
import 'package:my_spotify/models/AlbumDetailModel.dart';
import 'package:my_spotify/models/AlbumModel.dart';
import 'package:my_spotify/models/ArtistModel.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/models/track_model.dart';
import 'package:my_spotify/services/SpotifyAuthService.dart';

class ApiService {
  final Dio _dio;
  ApiService() : _dio = Dio();

  // Helper method to get headers with valid token
  Future<Options> _getAuthOptions() async {
    final token = await Spotifyauthservice().getValidToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  // Fetch single or multiple tracks by IDs
  Future<List<TrackModel>> getTracks(List<String> ids) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/tracks',
        queryParameters: {'ids': ids.join(','), 'market': 'ES'},
        options: options,
      );

      final data = response.data['tracks'] as List;

      return data.map((e) => TrackModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load tracks: $e');
    }
  }

  // Fetch a playlist and its tracks
  Future<PlaylistModel> getPlaylistTracks({required String playlistId}) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/playlists/$playlistId',
        queryParameters: {
          'fields':
              'name,owner(display_name),images,tracks.items(added_by.id,track(name,href,album,artists))',
        },
        options: options,
      );

      return PlaylistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load playlist tracks: $e');
    }
  }

  // Fetch album detail by album ID
  Future<AlbumModel> getAlbumInformation({required String albumId}) async {
    final options = await _getAuthOptions();
    try {
      final response = await _dio.get(
        'https://api.spotify.com/v1/albums/$albumId',
        options: options,
      );

      return AlbumModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load album information: $e');
    }
  }

  // Fetch single artist information
  Future<ArtistModel> getArtistInformation({required String artistId}) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId',
        options: options,
      );

      return ArtistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load artist information: $e');
    }
  }

  // Fetch multiple artists info by list of IDs
  Future<List<ArtistModel>> getArtistListInformation(List<String> ids) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists',
        queryParameters: {'ids': ids.join(','), 'market': 'ES'},
        options: options,
      );

      final items = response.data['artists'] as List;
      return items.map((item) => ArtistModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artists information: $e');
    }
  }

  // Fetch albums of an artist
  Future<List<AlbumModel>> fetchArtistAlbums(String artistId) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId/albums',
        options: options,
      );

      final items = response.data['items'] as List;
      return items.map((item) => AlbumModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artist albums: $e');
    }
  }

  // Fetch tracks in an album
  Future<AlbumTracksModel> fetchAlbumTracks(String albumId) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/albums/$albumId/tracks',
        options: options,
      );

      return AlbumTracksModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load album tracks: $e');
    }
  }

  // Fetch artist's top tracks
  Future<List<TrackModel>> fetchArtistTopTracks(String artistId) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        'https://api.spotify.com/v1/artists/$artistId/top-tracks',
        queryParameters: {'market': 'ES'},
        options: options,
      );

      final items = response.data['tracks'] as List;
      return items.map((item) => TrackModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load artist top tracks: $e');
    }
  }
}
