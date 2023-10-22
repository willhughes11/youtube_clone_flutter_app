import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone_flutter_app/pages/channel_page.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class TappableVideoCard extends StatelessWidget {
  final String baseUrl;
  final String? videoThumbnailUrl;
  final String? title;
  final String? subtitle;
  final String? videoId;
  final String? channelThumbnailUrl;
  final String? channelId;
  final bool isLoading;
  final ConnectionState connectionState;

  const TappableVideoCard({
    super.key,
    required this.baseUrl,
    this.videoThumbnailUrl,
    this.title,
    this.subtitle,
    this.videoId,
    this.channelThumbnailUrl,
    this.channelId,
    required this.isLoading,
    required this.connectionState,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(videoId);
      },
      child: Card(
        color: customBlack.shade900,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                debugPrint("Video: $videoId");
              },
              child:
                  _buildImageWidget(isLoading, connectionState, videoThumbnailUrl),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: SizedBox(
                width: 40,
                height: 40,
                child: _buildChannelImageWidget(
                  isLoading,
                  connectionState,
                  channelThumbnailUrl,
                  context,
                ),
              ),
              title: _buildTitleWidget(isLoading, connectionState, title),
              subtitle: Container(
                margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                child: Wrap(
                  children: [
                    _buildSubtitleWidget(isLoading, connectionState, subtitle)
                  ],
                ),
              ),
              trailing: _buildTrailingeWidget(isLoading, connectionState),
              onTap: () {
                debugPrint("Video $videoId");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(bool isLoading, ConnectionState connectionState,
      String? videoThumbnailUrl) {
    if (connectionState == ConnectionState.waiting || isLoading) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Center(
          child: Shimmer.fromColors(
            baseColor: customBlack.shade800,
            highlightColor: customBlack.shade700,
            enabled: isLoading,
            child: Container(
              color: customBlack.shade800,
              width: double.infinity,
              height: 250,
            ),
          ),
        ),
      );
    } else {
      return Image.network(videoThumbnailUrl ?? "");
    }
  }

  Widget _buildChannelImageWidget(
      bool isLoading,
      ConnectionState connectionState,
      String? channelThumbnailUrl,
      BuildContext context) {
    if (connectionState == ConnectionState.waiting || isLoading) {
      return ClipOval(
        child: Center(
          child: Shimmer.fromColors(
            baseColor: customBlack.shade800,
            highlightColor: customBlack.shade700,
            enabled: isLoading,
            child: Container(
              color: customBlack.shade800,
              width: double.infinity,
              height: 250,
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(0.0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ChannelPage(
                    baseUrl: baseUrl,
                    channelId: channelId!,
                  );
                },
              ),
            );
          },
          child: ClipOval(
            child: Image.network(
              channelThumbnailUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildTitleWidget(
      bool isLoading, ConnectionState connectionState, String? title) {
    if (connectionState == ConnectionState.waiting || isLoading) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Shimmer.fromColors(
          baseColor: customBlack.shade800,
          highlightColor: customBlack.shade700,
          enabled: isLoading,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            color: customBlack.shade800,
            width: 175,
            height: 20,
          ),
        ),
      );
    } else {
      return Text(
        title ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      );
    }
  }

  Widget _buildSubtitleWidget(
      bool isLoading, ConnectionState connectionState, String? subtitle) {
    if (connectionState == ConnectionState.waiting || isLoading) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Shimmer.fromColors(
          baseColor: customBlack.shade800,
          highlightColor: customBlack.shade700,
          enabled: isLoading,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            color: customBlack.shade800,
            width: 175,
            height: 15,
          ),
        ),
      );
    } else {
      return Text(
        subtitle ?? "",
        style: const TextStyle(color: Colors.grey),
      );
    }
  }

  Widget _buildTrailingeWidget(
      bool isLoading, ConnectionState connectionState) {
    if (connectionState == ConnectionState.waiting || isLoading) {
      return const SizedBox();
    } else {
      return GestureDetector(
        onTap: () {
          debugPrint("Video $videoId Options");
        },
        child: const Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
      );
    }
  }
}
