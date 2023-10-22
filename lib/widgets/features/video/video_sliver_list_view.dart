import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/videos/videos.dart';
import 'package:youtube_clone_flutter_app/utils/functions.dart';
import 'package:youtube_clone_flutter_app/widgets/features/video/tappable_video_card.dart';

class VideoSliverListView extends StatelessWidget {
  final String baseUrl;
  final Videos? data;
  final bool isLoading;
  final ConnectionState connectionState;
  const VideoSliverListView({
    super.key,
    required this.baseUrl,
    required this.data,
    required this.isLoading,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (isLoading) {
            return TappableVideoCard(
              baseUrl: baseUrl,
              isLoading: isLoading,
              connectionState: connectionState,
            );
          } else {
            if (index < data!.items.length) {
              final videoItem = data!.items[index];
              var channelTitle = videoItem.snippet!.channelTitle;
              var viewCount = videoItem.statistics!.viewCount;
              var publishedAt = videoItem.snippet!.publishedAt;
              var subtitle =
                  "$channelTitle • ${formatNumber(viewCount)} views • ${calculateRelativeTime(publishedAt)}";
              return TappableVideoCard(
                baseUrl: baseUrl,
                videoThumbnailUrl: videoItem.snippet!.thumbnails.maxres?.url ??
                    videoItem.snippet!.thumbnails.high.url,
                title: videoItem.snippet!.title,
                subtitle: subtitle,
                videoId: videoItem.id,
                channelThumbnailUrl:
                    videoItem.snippet!.channelThumbnails?.high.url,
                channelId: videoItem.snippet!.channelId,
                isLoading: isLoading,
                connectionState: connectionState,
              );
            }
          }
          return null;
        },
      ),
    );
  }
}
