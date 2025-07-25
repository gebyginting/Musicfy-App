import 'package:dio/dio.dart';
import 'package:my_spotify/services/SpotifyAuthService.dart';

class Apiservice {
  final Dio _dio = Dio();

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
}
