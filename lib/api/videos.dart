import 'package:http/http.dart' as http;
import 'package:youtube_clone_flutter_app/models/videos/videos.dart';
import 'dart:convert';

Future<Videos> fetchPopularVideos(String baseUrl,
    [String? videoCategoryId = '0', String? nextPageToken]) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/videos/mostPopular',
    queryParameters: {
      'vcid': videoCategoryId,
      'npt': nextPageToken
    },
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return Videos.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load popular videos');
  }
}

Future<Videos> fetchVideosByChannelId(String baseUrl, String channelId,
    [String? order, String? nextPageToken]) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/videos/channel/$channelId',
    queryParameters: {
      'order': order ?? "date",
      'npt': nextPageToken,
      'gfd': "true"
    },
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return Videos.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load channel videos');
  }
}