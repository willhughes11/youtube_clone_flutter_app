import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/models/channel_section_item.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class ChannelHomeTabView extends StatelessWidget {
  final String channelId;
  final List<ChannelSectionItem> channelSectionItems;
  const ChannelHomeTabView(
      {super.key, required this.channelId, required this.channelSectionItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: customBlack.shade900,
        child: Center(
          child: Column(
            children: [
              for (var item in channelSectionItems)
                Text(
                  item.snippet.type,
                  style: TextStyle(color: Colors.white),
                )
            ],
          ),
        ),
      ),
    );
  }
}
