import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/videos/videos.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/utils/functions.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channels/skeletons/channel_video_card_skeleton.dart';

class ChannelVideosTabView extends StatelessWidget {
  final String channelId;
  final int selectedOrderIndex;
  final List<String> videoOrderOptions;
  final Function(int) updateSelectedVideoChannelOrder;
  final Future<Videos> futureVideosByChannelId;
  final Function(int) fetchChannelVideosAndUpdateState;
  final bool isLoading;
  final ScrollController scrollController;
  const ChannelVideosTabView({
    super.key,
    required this.channelId,
    required this.selectedOrderIndex,
    required this.videoOrderOptions,
    required this.updateSelectedVideoChannelOrder,
    required this.futureVideosByChannelId,
    required this.fetchChannelVideosAndUpdateState,
    required this.isLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            for (int index = 0; index < videoOrderOptions.length; index++)
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: MaterialButton(
                  padding: const EdgeInsets.all(8.0),
                  minWidth: 75,
                  height: 0,
                  onPressed: () {
                    updateSelectedVideoChannelOrder(index);
                    fetchChannelVideosAndUpdateState(index);
                  },
                  color: index == selectedOrderIndex
                      ? Colors.white
                      : customBlack.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Text(
                    videoOrderOptions[index],
                    style: TextStyle(
                        color: index == selectedOrderIndex
                            ? Colors.black
                            : Colors.white),
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: FutureBuilder<Videos>(
            future: futureVideosByChannelId,
            builder: (context, videosSnapshot) {
              var connectionState = videosSnapshot.connectionState;
              if (connectionState == ConnectionState.waiting || isLoading) {
                return ListView.builder(
                  itemCount: 5,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    return ChannelVideoCardSkeleton(
                      isLoading: isLoading,
                      connectionState: connectionState,
                      title: "Title of Video Placeholder",
                      subtitle: "Subtitle of Video",
                    );
                  },
                );
              } else if (videosSnapshot.hasError) {
                return Text('Error: ${videosSnapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: videosSnapshot.data?.items.length ?? 5,
                  itemBuilder: (BuildContext context, int index) {
                    var videos = videosSnapshot.data;
                    var viewCount = videos!.items[index].statistics!.viewCount;
                    var publishedAt = videos.items[index].snippet!.publishedAt;
                    var videoThumbnail =
                        videos.items[index].snippet!.thumbnails.high.url;
                    var title = videos.items[index].snippet!.title;
                    var subtitle =
                        "${formatNumber(viewCount)} views • ${calculateRelativeTime(publishedAt)}";
                    return ChannelVideoCardSkeleton(
                      isLoading: isLoading,
                      connectionState: connectionState,
                      videoThumbnail: videoThumbnail,
                      title: title,
                      subtitle: subtitle,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
