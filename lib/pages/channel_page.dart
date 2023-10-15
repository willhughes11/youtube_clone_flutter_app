import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/api/channels.dart';
import 'package:youtube_clone_flutter_app/models/channel/channel.dart';
import 'package:youtube_clone_flutter_app/models/channel/models/channel_item.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_home_tab.dart';
import 'package:youtube_clone_flutter_app/widgets/features/channel/channel_info_header.dart';
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
  final int selectedFilterId = 0;
  List<String> channelTabOptions = [];
  List<Widget> channelTabViewOptions = [];

  @override
  void initState() {
    super.initState();
    baseUrl = widget.baseUrl;
    channelId = widget.channelId;
    futureChannel = fetchChannelById(baseUrl, channelId);

    channelTabOptions = [
      'Home',
      'Videos',
      'Shorts',
      'Live',
      'Playlist',
      'Community',
      'Channels',
      'About'
    ];

    channelTabViewOptions = [
      ChannelHomeTab(
        channelId: channelId,
      ),
      for (int i = 1; i < 8; i++)
        const SizedBox(
          width: 0.0,
          height: 0.0,
        ),
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
            body: DefaultTabController(
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
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            indicatorWeight: 2.75,
                            tabs: [
                              for (var item in channelTabOptions)
                                Tab(
                                  text: item,
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    child: TabBarView(children: channelTabViewOptions),
                  )
                ],
              )),
            ),
          );
        }
      },
    );
  }
}
