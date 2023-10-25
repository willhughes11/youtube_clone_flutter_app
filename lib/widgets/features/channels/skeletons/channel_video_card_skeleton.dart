import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class ChannelVideoCardSkeleton extends StatelessWidget {
  final bool isLoading;
  final String? videoThumbnail;
  final String? title;
  final String? subtitle;
  final ConnectionState connectionState;

  const ChannelVideoCardSkeleton(
      {super.key,
      required this.isLoading,
      required this.connectionState,
      this.videoThumbnail,
      this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: _buildImageWidget(isLoading, connectionState, videoThumbnail),
        ),
        Expanded(
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitleWidget(isLoading, connectionState, title),
                _buildSubtitleWidget(isLoading, connectionState, subtitle)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageWidget(
      bool isLoading, ConnectionState connectionState, String? thumbnailUrl) {
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
              width: 100,
              height: 70,
            ),
          ),
        ),
      );
    } else {
      return Image.network(
        videoThumbnail ?? "",
        width: 100,
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
        maxLines: 3,
        style: const TextStyle(color: Colors.white),
        softWrap: true,
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
            width: 125,
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
}
