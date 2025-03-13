import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/music_response.dart';

class MusicService {
  static const String _baseUrl =
      'https://api-dev.xulu.co.id/v1/api/bridge/music';
  final String token;

  MusicService({required this.token});

  Future<MusicResponse> getMusicList() async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "httpMethod": "GET",
          "data": {"kode": "ORG0012", "fieldName": "fileAudio"}
        }),
      );

      if (response.statusCode == 200) {
        return MusicResponse.fromJson(jsonDecode(response.body));
      }
      throw Exception('Failed to load music list');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
