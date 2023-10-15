import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/videos/videos.dart';
import 'package:youtube_clone_flutter_app/widgets/features/video/tappable_video_card.dart';

class VideoSliverListView extends StatelessWidget {
  final String baseUrl;
  final Videos? data;
  const VideoSliverListView({super.key, required this.baseUrl, required this.data});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index < data!.items.length) {
            final videoItem = data!.items[index];
            return TappableVideoCard(
              baseUrl: baseUrl,
              videoThumbnailUrl: videoItem.snippet!.thumbnails.maxres?.url ??
                  videoItem.snippet!.thumbnails.high.url,
              title: videoItem.snippet!.title,
              channelTitle: videoItem.snippet!.channelTitle,
              viewCount: videoItem.statistics!.viewCount,
              publishedAt: videoItem.snippet!.publishedAt,
              videoId: videoItem.id,
              channelThumbnailUrl:
                  videoItem.snippet!.channelThumbnails?.high.url,
              channelId: videoItem.snippet!.channelId,
            );
          }
          return null;
        },
      ),
    );
  }
}
