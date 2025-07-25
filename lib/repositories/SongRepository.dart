import 'package:my_spotify/models/TrackModel.dart';
import 'package:my_spotify/services/ApiService.dart';

class Songrepository {
  final Apiservice _api = Apiservice();

  Future<List<TrackModel>> fetchTracks(List<String> ids) async {
    final response = await _api.getTracks(ids);

    final List<dynamic> data = response.data['tracks'];
    return data.map((json) => TrackModel.fromJson(json)).toList();
  }
}
