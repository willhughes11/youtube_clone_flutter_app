import 'package:flutter/material.dart';

class ChannelVideosTab extends StatefulWidget {
  final String channelId;
  const ChannelVideosTab({super.key, required this.channelId});

  @override
  State<ChannelVideosTab> createState() => _ChannelVideosTabState();
}

class _ChannelVideosTabState extends State<ChannelVideosTab> {
  late String channelId;
  @override
  void initState() {
    super.initState();
    channelId = widget.channelId;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(child: MaterialButton(onPressed: (){}),)
    ],);
  }
}