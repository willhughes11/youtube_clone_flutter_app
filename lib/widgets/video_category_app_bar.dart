import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/widgets/video_filter_bar.dart';

class VideoCategoryAppBar extends StatelessWidget {
  final String baseUrl;
  final String selectedFilterId;
  final List<Item> categoryItems;
  final Function(String) updateSelectedFilterCategory;
  final Function(String, String) fetchAndSetPopularVideos;

  const VideoCategoryAppBar(
      {super.key,
      required this.baseUrl,
      required this.selectedFilterId,
      required this.categoryItems,
      required this.updateSelectedFilterCategory,
      required this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: customBlack.shade800,
      floating: true,
      flexibleSpace: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: VideoFilterBar(
            selectedFilterId: selectedFilterId,
            filterItems: categoryItems,
            baseUrl: baseUrl,
            updateSelectedFilterCategory: updateSelectedFilterCategory,
            fetchAndSetPopularVideos: fetchAndSetPopularVideos),
      ),
    );
  }
}
