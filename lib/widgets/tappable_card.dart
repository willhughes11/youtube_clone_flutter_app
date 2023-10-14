import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/utils/functions.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/widgets/video_loading_spinner.dart';

class TappableCard extends StatelessWidget {
  final String videoThumbnailUrl;
  final String title;
  final String channelTitle;
  final String viewCount;
  final String publishedAt;
  final String videoId;
  final String? channelThumbnailUrl;
  final String channelId;

  const TappableCard(
      {super.key,
      required this.videoThumbnailUrl,
      required this.title,
      required this.channelTitle,
      required this.viewCount,
      required this.publishedAt,
      required this.videoId,
      this.channelThumbnailUrl,
      required this.channelId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(videoId);
      },
      child: Card(
        color: customBlack.shade800,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                debugPrint("Video: $videoId");
              },
              child: Image.network(
                videoThumbnailUrl,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // The image is loaded, display it.
                  } else {
                    return const Center(
                      child: VideoLoadingSpinner(
                        optionalColor: Colors.grey,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  // Handle any errors that occur when loading the image.
                  return Image.asset(
                      'assets/images/error_placeholder.png'); // You can replace with your own error placeholder.
                },
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: channelThumbnailUrl != null
                  ? Container(
                      padding: const EdgeInsets.all(0.0),
                      child: GestureDetector(
                        onTap: () {
                          debugPrint("Channel $channelId");
                        },
                        child: ClipOval(
                          child: Image.network(
                            channelThumbnailUrl!,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : null,
              title: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              subtitle: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: Wrap(
                  children: [
                    Text(
                      channelTitle,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: const Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    Text(
                      '${formatNumber(viewCount)} views',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: const Text(
                        '•',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    Text(
                      calculateRelativeTime(publishedAt),
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  debugPrint("Video $videoId Options");
                },
                child: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                debugPrint("Video $videoId");
              },
            ),
          ],
        ),
      ),
    );
  }
}
