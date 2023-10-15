import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/api/channels.dart';
import 'package:live_sync_flutter_app/models/channel.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/widgets/channel_info_header.dart';
import 'package:live_sync_flutter_app/widgets/video_loading_spinner.dart';

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
  List<String> channelContentOptions = [
    'Home',
    'Videos',
    'Shorts',
    'Live',
    'Playlist',
    'Community',
    'Channels',
    'About'
  ];

  @override
  void initState() {
    super.initState();
    baseUrl = widget.baseUrl;
    channelId = widget.channelId;
    futureChannel = fetchChannelById(baseUrl, channelId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Channel>(
      future: futureChannel,
      builder: (context, channelSnapshot) {
        if (channelSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: customBlack.shade800,
            body: const VideoLoadingSpinner(
              optionalColor: Colors.grey,
            ),
          );
        } else if (channelSnapshot.hasError) {
          return Scaffold(
            backgroundColor: customBlack.shade800,
            body: Text('Error: ${channelSnapshot.error}'),
          );
        } else {
          Item channelItem = channelSnapshot.data!.items[0];
          return Scaffold(
            appBar: AppBar(
              backgroundColor: customBlack.shade800,
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
                    channelItem.snippet!.title,
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
            backgroundColor: customBlack.shade800,
            body: Center(
              child: CustomScrollView(
                slivers: [
                  ChannelInfoHeader(
                    channelItem: channelItem,
                  ),
                  SliverAppBar(
                    backgroundColor: customBlack.shade800,
                    automaticallyImplyLeading: false,
                    floating: true,
                    toolbarHeight: 50,
                    flexibleSpace: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: DefaultTabController(
                          length: channelContentOptions.length,
                          animationDuration: Duration.zero,
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            tabs: [
                              for (var item in channelContentOptions)
                                Tab(
                                  text: item,
                                )
                            ],
                          ),
                        )),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          title: Text('Item $index', style: const TextStyle(color: Colors.white),),
                        );
                      },
                      childCount: 1000,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
