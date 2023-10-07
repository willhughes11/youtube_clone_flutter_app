import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';
import 'package:live_sync_flutter_app/widgets/material_video_filter_button.dart';

class VideoFilterBar extends StatelessWidget {
  final String baseUrl;
  final String selectedVideoCategoryId;
  final List<Item> categoryItems;
  final Function(String) updateSelectedVideoCategory;
  final Function(String, String) fetchAndSetPopularVideos;

  const VideoFilterBar(
      {super.key,
      required this.baseUrl,
      required this.selectedVideoCategoryId,
      required this.categoryItems,
      required this.updateSelectedVideoCategory,
      required this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var item in categoryItems)
          SizedBox(
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 0,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: MaterialVideoFilterButton(
                      selectedVideoCategoryId: selectedVideoCategoryId,
                      categoryItem: item,
                      baseUrl: baseUrl,
                      updateSelectedVideoCategory: updateSelectedVideoCategory,
                      fetchAndSetPopularVideos: fetchAndSetPopularVideos),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
