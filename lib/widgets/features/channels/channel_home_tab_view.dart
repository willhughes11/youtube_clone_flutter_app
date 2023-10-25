import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/models/channel_section_item.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel_sections/single_playlist_section.dart';

class ChannelHomeTabView extends StatelessWidget {
  final String baseUrl;
  final String channelId;
  final List<ChannelSectionItem> channelSectionItems;
  const ChannelHomeTabView({
    super.key,
    required this.baseUrl,
    required this.channelId,
    required this.channelSectionItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: customBlack.shade900,
        child: Center(
          child: Column(
            children: [
              for (var item in channelSectionItems)
                if (item.snippet.type == 'recentuploads')
                  Text(
                    item.snippet.type,
                    style: const TextStyle(color: Colors.blue),
                  )
                else if (item.snippet.type == 'singleplaylist')
                  SinglePlaylistSection(
                    baseUrl: baseUrl,
                    playlistId: item.contentDetails!.playlists!.first,
                  )
                else if (item.snippet.type == 'multiplechannels')
                  Text(
                    item.snippet.type,
                    style: const TextStyle(color: Colors.orange),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
