import 'package:http/http.dart' as http;
import 'package:youtube_clone_flutter_app/models/playlists/playlists.dart';

import 'dart:convert';

Future<Playlists> fetchPlaylistById(String baseUrl, String playlistId) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/playlists/$playlistId',
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return Playlists.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load channel by ID');
  }
}
