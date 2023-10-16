import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/api/channel_sections.dart';
import 'package:youtube_clone_flutter_app/api/channels.dart';
import 'package:youtube_clone_flutter_app/models/channel/channel.dart';
import 'package:youtube_clone_flutter_app/models/channel/models/channel_item.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/channel_sections.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_home_tab.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_info_header.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_tab_bar.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_videos.tab.dart';
import 'package:youtube_clone_flutter_app/widgets/global/custom_loading_spinner.dart';

class ChannelPage extends StatefulWidget {
  final String baseUrl;
  final String channelId;
  const ChannelPage(
      {super.key, required this.baseUrl, required this.channelId});

  @override
  State<ChannelPage> createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  late String baseUrl;
  late String channelId;
  late Future<Channel> futureChannel;
  late Future<ChannelSections> futureChannelSection;
  final int selectedFilterId = 0;
  List<String> channelTabOptions = [];
  List<Widget> channelTabViewOptions = [];

  @override
  void initState() {
    super.initState();
    baseUrl = widget.baseUrl;
    channelId = widget.channelId;
    futureChannel = fetchChannelById(baseUrl, channelId);
    futureChannelSection = fetchChannelSectionsByChannelId(baseUrl, channelId);

    channelTabOptions = [
      'Home',
      'Videos',
      'Shorts',
      'Live',
      'Playlist',
      'Community',
      'Channels',
      'About',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Channel>(
      future: futureChannel,
      builder: (context, channelSnapshot) {
        if (channelSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: customBlack.shade900,
            body: const CustomLoadingSpinner(
              optionalColor: Colors.grey,
            ),
          );
        } else if (channelSnapshot.hasError) {
          return Scaffold(
            backgroundColor: customBlack.shade900,
            body: Text('Error: ${channelSnapshot.error}'),
          );
        } else {
          ChannelItem channelItem = channelSnapshot.data!.items[0];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: customBlack.shade900,
              automaticallyImplyLeading: false,
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    channelItem.snippet.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              leadingWidth: double.maxFinite,
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle),
                )
              ],
            ),
            backgroundColor: customBlack.shade900,
            body: FutureBuilder<ChannelSections>(
              future: futureChannelSection,
              builder: (context, channelSectionSnapshot) {
                if (channelSectionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Scaffold(
                    backgroundColor: customBlack.shade900,
                    body: const CustomLoadingSpinner(
                      optionalColor: Colors.grey,
                    ),
                  );
                } else if (channelSectionSnapshot.hasError) {
                  return Scaffold(
                    backgroundColor: customBlack.shade900,
                    body: Text('Error: ${channelSectionSnapshot.error}'),
                  );
                } else {
                  var channelSectionItems = channelSectionSnapshot.data!.items;
                  return DefaultTabController(
                    length: channelTabOptions.length,
                    animationDuration: Duration.zero,
                    child: Center(
                        child: CustomScrollView(
                      slivers: [
                        ChannelInfoHeader(
                          channelItem: channelItem,
                        ),
                        SliverAppBar(
                          backgroundColor: customBlack.shade900,
                          automaticallyImplyLeading: false,
                          floating: true,
                          toolbarHeight: 50,
                          flexibleSpace: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: ChannelTabBar(
                                channelTabOptions: channelTabOptions,
                              )),
                        ),
                        SliverFillRemaining(
                          child: TabBarView(
                              children: channelTabViewOptions = [
                            ChannelHomeTab(
                              channelId: channelId,
                              channelSectionItems: channelSectionItems
                            ),
                            ChannelVideosTab(channelId: channelId,),
                            for (int i = 1; i < 7; i++)
                              const SizedBox(
                                width: 0.0,
                                height: 0.0,
                              ),
                          ]),
                        )
                      ],
                    )),
                  );
                }
              },
            ),
          );
        }
      },
    );
  }
}
