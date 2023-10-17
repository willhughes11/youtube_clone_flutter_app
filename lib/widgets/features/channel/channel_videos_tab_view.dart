import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/videos/videos.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/widgets/global/custom_loading_spinner.dart';

class ChannelVideosTabView extends StatelessWidget {
  final String channelId;
  final int selectedOrderIndex;
  final List<String> videoOrderOptions;
  final Function(int) updateSelectedVideoChannelOrder;
  final Future<Videos> futureVideosByChannelId;
  final Function(int) fetchChannelVideosAndUpdateState;
  final bool isLoading;
  const ChannelVideosTabView({
    super.key,
    required this.channelId,
    required this.selectedOrderIndex,
    required this.videoOrderOptions,
    required this.updateSelectedVideoChannelOrder,
    required this.futureVideosByChannelId,
    required this.fetchChannelVideosAndUpdateState,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

      // children: [
      //   Row(
      //     children: [
      //       for (int index = 0; index < videoOrderOptions.length; index++)
      //         Container(
      //           margin: const EdgeInsets.all(4.0),
      //           child: MaterialButton(
      //             padding: const EdgeInsets.all(8.0),
      //             minWidth: 75,
      //             height: 0,
      //             onPressed: () {
      //               updateSelectedVideoChannelOrder(index);
      //               fetchChannelVideosAndUpdateState(index);
      //             },
      //             color: index == selectedOrderIndex
      //                 ? Colors.white
      //                 : customBlack.shade700,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(24.0),
      //             ),
      //             child: Text(
      //               videoOrderOptions[index],
      //               style: TextStyle(
      //                   color: index == selectedOrderIndex
      //                       ? Colors.black
      //                       : Colors.white),
      //             ),
      //           ),
      //         ),
      //     ],
      //   ),
      //   Expanded(
      //     child: FutureBuilder<Videos>(
      //       future: futureVideosByChannelId,
      //       builder: (context, videosSnapshot) {
      //         if (videosSnapshot.connectionState == ConnectionState.waiting ||
      //             isLoading) {
      //           return const CustomLoadingSpinner(
      //             optionalColor: Colors.grey,
      //           );
      //         } else if (videosSnapshot.hasError) {
      //           return Text('Error: ${videosSnapshot.error}');
      //         } else {
      //           return SliverList(
      //             delegate: SliverChildBuilderDelegate(
      //               (BuildContext context, int index) {
      //                 var videos = videosSnapshot.data;
      //                 // return Text(
      //                 //   videos!.items[index].snippet!.title,
      //                 //   style: const TextStyle(color: Colors.white),
      //                 // );
      //                 return ListTile(
      //                   leading: Image.network(
      //                       videos!.items[index].snippet!.thumbnails.high.url),
      //                   title: Column(
      //                     children: [
      //                       Text(
      //                         videos.items[index].snippet!.title,
      //                         style: TextStyle(color: Colors.white),
      //                       )
      //                     ],
      //                   ),
      //                 );
      //               },
      //               childCount: videosSnapshot.data!.items.length
      //             ),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ],
