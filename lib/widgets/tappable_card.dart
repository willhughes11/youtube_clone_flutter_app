import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/utils/functions.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';

class TappableCard extends StatelessWidget {
  final String videoThumbnailUrl;
  final String title;
  final String channelTitle;
  final String viewCount;
  final String publishedAt;
  final String videoId;
  final String channelThumbnailUrl;
  final String channelId;

  const TappableCard(
      {super.key,
      required this.videoThumbnailUrl,
      required this.title,
      required this.channelTitle,
      required this.viewCount,
      required this.publishedAt,
      required this.videoId,
      required this.channelThumbnailUrl,
      required this.channelId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here
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
              child: Image.network(videoThumbnailUrl),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: Container(
                padding: const EdgeInsets.all(0.0),
                child: GestureDetector(
                  onTap: () {
                    debugPrint("Channel $channelId");
                  },
                  child: ClipOval(
                    child: Image.network(
                      channelThumbnailUrl,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              subtitle: Wrap(children: [
                Text(
                  channelTitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: const Text(
                    '•',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                Text(
                  '${formatNumber(viewCount)} views',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: const Text(
                    '•',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                Text(
                  calculateRelativeTime(publishedAt),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
              ]),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.white,
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
