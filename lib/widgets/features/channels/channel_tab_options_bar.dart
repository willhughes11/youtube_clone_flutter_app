import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class ChannelTabOptionsBar extends StatelessWidget {
  final List<String> channelTabOptions;
  const ChannelTabOptionsBar({super.key, required this.channelTabOptions});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: customBlack.shade900,
      automaticallyImplyLeading: false,
      floating: true,
      pinned: true,
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
        child: TabBar(
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
              ),
          ],
        ),
      ),
    );
  }
}
