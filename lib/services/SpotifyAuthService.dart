import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Spotifyauthservice {
  static const _clientId = "b6b7b0a74dd7408b94e02c8d700d8764";
  static const _clientSecret = "46576e47c4cd477cad4d699275929c45";

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
      if (DateTime.now().isBefore(expiry)) return token;
    }

    return await getToken();
  }
}
