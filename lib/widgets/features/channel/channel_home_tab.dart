import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class ChannelHomeTab extends StatefulWidget {
  final String channelId;
  const ChannelHomeTab({super.key, required this.channelId});

  @override
  State<ChannelHomeTab> createState() => _ChannelHomeTabState();
}

class _ChannelHomeTabState extends State<ChannelHomeTab> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: customBlack.shade900),
    );
  }
}
