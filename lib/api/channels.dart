import 'package:http/http.dart' as http;
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';

import 'dart:convert';

Future<Map<String, ChannelThumbnails>> fetchChannelThumbnailsForPopularVideos(
    PopularVideos mostPopularVideos, String baseUrl) async {
  final Map<String, ChannelThumbnails> channelThumbnailsMap = {};

  final channelIdsToFetch = List.from(
      mostPopularVideos.items.map((video) => video.snippet!.channelId));

// Iterate over the copied keys and update the channelThumbnailsMap
  for (var channelId in channelIdsToFetch) {
    final response = await http
        .get(Uri.parse('$baseUrl/api/v1/channel/$channelId/thumbnails'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final channelThumbnails = ChannelThumbnails.fromJson(data);
      channelThumbnailsMap[channelId] = channelThumbnails;
    } else {
      throw Exception('Failed to load channel thumbnails');
    }
  }

  return channelThumbnailsMap;
}
