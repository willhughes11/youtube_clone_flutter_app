import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/channel/models/channel_item.dart';
import 'package:youtube_clone_flutter_app/utils/functions.dart';

class ChannelInfoHeader extends StatelessWidget {
  final ChannelItem channelItem;
  const ChannelInfoHeader({super.key, required this.channelItem});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(
              maxHeight: 80.0,
            ),
            child: ClipRRect(
              child: Image.network(
                channelItem.brandingSettings.image!.bannerExternalUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      channelItem.snippet.thumbnails.high.url,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                    child: Text(
                      channelItem.snippet.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      channelItem.snippet.customUrl!,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    child: Text(
                      "${formatNumber(channelItem.statistics.subscriberCount!)} subscribers • ${formatNumber(channelItem.statistics.videoCount!)} videos",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: Text(
                            channelItem.snippet.description?.split('\n')[0] ??
                                'More about this channel',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                    child: MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      color: Colors.white,
                      minWidth: double.infinity,
                      child: const Text(
                        "Subscribe",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
