import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/widgets/tappable_card.dart';

class VideoSliverListView extends StatelessWidget {
  final PopularVideos? data;
  const VideoSliverListView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index < data!.items.length) {
            final videoItem = data!.items[index];
            return TappableCard(
              videoThumbnailUrl: videoItem.snippet!.thumbnails?.maxres?.url ??
                  videoItem.snippet!.thumbnails!.high.url,
              title: videoItem.snippet!.title,
              channelTitle: videoItem.snippet!.channelTitle!,
              viewCount: videoItem.statistics!.viewCount,
              publishedAt: videoItem.snippet!.publishedAt!,
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
