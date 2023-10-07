import 'package:http/http.dart' as http;
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';

import 'dart:convert';

Future<Map<String, ChannelThumbnails>> fetchChannelThumbnailsForPopularVideos(
      PopularVideos mostPopularVideos, String baseUrl) async {
    final Map<String, ChannelThumbnails> channelThumbnailsMap = {};

    for (var video in mostPopularVideos.items) {
      final response = await http.get(Uri.parse(
          '$baseUrl/api/v1/channel/${video.snippet!.channelId}/thumbnails'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final channelThumbnails = ChannelThumbnails.fromJson(data);
        channelThumbnailsMap[video.snippet!.channelId] = channelThumbnails;
      } else {
        throw Exception('Failed to load channel thumbnails');
      }
    }

    return channelThumbnailsMap;
  }