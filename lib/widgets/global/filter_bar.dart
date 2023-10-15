import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/video_categories/models/video_category_item.dart';
import 'package:youtube_clone_flutter_app/widgets/global/material_filter_button.dart';

class VideoFilterBar extends StatelessWidget {
  final String baseUrl;
  final String selectedFilterId;
  final List<VideoCategoryItem> filterItems;
  final Function(String) updateSelectedFilterCategory;
  final Function(String, String) fetchAndSetPopularVideos;

  const VideoFilterBar(
      {super.key,
      required this.baseUrl,
      required this.selectedFilterId,
      required this.filterItems,
      required this.updateSelectedFilterCategory,
      required this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var item in filterItems)
          if (item.snippet.assignable != null)
            SizedBox(
              child: Container(
                constraints: const BoxConstraints(
                  minWidth: 0,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: MaterialVideoFilterButton(
                  selectedFilterId: selectedFilterId,
                  filterItem: item,
                  baseUrl: baseUrl,
                  updateSelectedFilterCategory: updateSelectedFilterCategory,
                  fetchAndSetPopularVideos: fetchAndSetPopularVideos,
                ),
              ),
            ),
      ],
    );
  }
}
