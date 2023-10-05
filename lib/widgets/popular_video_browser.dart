import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/widgets/tappable_card.dart';

Widget popularVideoBrowser(PopularVideos? popularVideos,
    Map<String, ChannelThumbnails>? channelThumbnailsMap) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Add widgets here to display the API data in a Column
        if (popularVideos != null)
          for (var video in popularVideos.items)
            TappableCard(
              videoThumbnailUrl: video.snippet.thumbnails.maxres?.url ??
                  video.snippet.thumbnails.high.url,
              title: video.snippet.title,
              channelTitle: video.snippet.channelTitle,
              viewCount: video.statistics.viewCount,
              publishedAt: video.snippet.publishedAt,
              videoId: video.id,
              channelThumbnailUrl:
                  channelThumbnailsMap![video.snippet.channelId]
                          ?.thumbnails
                          .high
                          .url ??
                      '',
              channelId: video.snippet.channelId,
            )
      ],
    ),
  );
}
