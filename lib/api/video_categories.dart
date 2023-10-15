import 'package:http/http.dart' as http;
import 'package:youtube_clone_flutter_app/models/video_categories.dart';
import 'dart:convert';

Future<VideoCategories> fetchVideoCategories(String baseUrl) async {
  final response = await http
      .get(Uri.parse('$baseUrl/api/v1/videosCategories'));

  if (response.statusCode == 200) {
    return VideoCategories.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load popular videos');
  }
}