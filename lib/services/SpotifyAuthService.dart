import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spotifyauthservice {
  final String _clientId = dotenv.env['SPOTIFY_CLIENT_ID'] ?? '';
  final String _clientSecret = dotenv.env['SPOTIFY_CLIENT_SECRET'] ?? '';

  Future<String> getToken() async {
    final credentials = base64.encode(utf8.encode('$_clientId:$_clientSecret'));

    final response = await Dio().post(
      'https://accounts.spotify.com/api/token',
      data: {'grant_type': 'client_credentials'},
      options: Options(
        headers: {
          'Authorization': 'Basic $credentials',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    );

    final token = response.data['access_token'];
    final expiresIn = response.data['expires_in'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('spotify_token', token);
    await prefs.setString(
      'spotify_token_expiry',
      DateTime.now().add(Duration(seconds: expiresIn)).toIso8601String(),
    );

    return token;
  }

  Future<String> getValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('spotify_token');
    final expiryString = prefs.getString('spotify_token_expiry');

    if (token != null && expiryString != null) {
      final expiry = DateTime.parse(expiryString);
      print("TOKEN: $token");
      if (DateTime.now().isBefore(expiry)) return token;
    }

    return await getToken();
  }
}
