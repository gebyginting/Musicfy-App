import 'package:dio/dio.dart';
import 'package:my_spotify/models/PlaylistModel.dart';
import 'package:my_spotify/services/SpotifyAuthService.dart';

class Apiservice {
  final Dio _dio = Dio();

  // FETCH TRACKS
  Future<Response> getTracks(List<String> ids) async {
    final token = await Spotifyauthservice().getValidToken();

    return _dio.get(
      'https://api.spotify.com/v1/tracks',
      queryParameters: {
        'ids': ids.join(','), // ubah list ke string dipisah koma
        // 'ids': '7qCAVkHWZkF44OzOUKf8Cr,3NxJKoYi9WMBuZdk4UdJuK',
        'market': 'ES',
      },
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
              'name,owner(display_name),images,tracks.items(added_by.id,track(name,href,album(name,href),artists))',
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return PlaylistModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load playlist tracks: $e');
    }
  }
}
