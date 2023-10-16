import 'package:flutter/material.dart';

class ChannelTabBar extends StatelessWidget {
  final List<String> channelTabOptions;
  const ChannelTabBar({super.key, required this.channelTabOptions});

  @override
  Widget build(BuildContext context) {
    return TabBar(
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
    );
  }
}
