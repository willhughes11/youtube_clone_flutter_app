import 'package:http/http.dart' as http;
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/models/video_categories.dart';
import 'dart:convert';

Future<PopularVideos> fetchPopularVideos(String baseUrl,
    [String? videoCategoryId = '0', String? nextPageToken]) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/videos/most-popular',
    queryParameters: {
      "vcid": videoCategoryId,
      "npt": nextPageToken
    },
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return PopularVideos.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load popular videos');
  }
}

Future<VideoCategories> fetchVideoCategories(String baseUrl) async {
  final response = await http
      .get(Uri.parse('$baseUrl/api/v1/videos/categories'));

  if (response.statusCode == 200) {
    return VideoCategories.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load popular videos');
  }
}
