import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/models/video_categories/models/video_category_item.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';

class MaterialVideoFilterButton extends StatelessWidget {
  final String? baseUrl;
  final String? selectedFilterId;
  final VideoCategoryItem? filterItem;
  final Function(String)? updateSelectedFilterCategory;
  final Function(String, String)? fetchAndSetPopularVideos;

  const MaterialVideoFilterButton(
      {super.key,
      this.baseUrl,
      this.selectedFilterId,
      this.filterItem,
      this.updateSelectedFilterCategory,
      this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    if (baseUrl != null &&
        selectedFilterId != null &&
        filterItem != null &&
        updateSelectedFilterCategory != null &&
        fetchAndSetPopularVideos != null) {
      return _buildMaterialButtonContent(
          baseUrl!,
          selectedFilterId!,
          filterItem!,
          updateSelectedFilterCategory!,
          fetchAndSetPopularVideos!);
    } else {
      return _buildMaterialButtonIconOnly(Icons.explore_outlined);
    }
  }

  Widget _buildMaterialButtonContent(
      String baseUrl,
      String selectedFilterId,
      VideoCategoryItem filterItem,
      Function(String) updateSelectedFilterCategory,
      Function(String, String) fetchAndSetPopularVideos) {
    return MaterialButton(
      onPressed: () {
        const defaultFilterId = "0";
        if (selectedFilterId == filterItem.id) {
          if (selectedFilterId != defaultFilterId) {
            updateSelectedFilterCategory(defaultFilterId);
            fetchAndSetPopularVideos(baseUrl, defaultFilterId);
          }
        } else {
          updateSelectedFilterCategory(filterItem.id);
          fetchAndSetPopularVideos(baseUrl, filterItem.id);
        }
      },
      padding: const EdgeInsets.all(8.0),
      minWidth: 45,
      height: 0,
      color: selectedFilterId == filterItem.id
          ? Colors.white
          : customBlack.shade700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        filterItem.snippet.title,
        style: TextStyle(
          color:
              selectedFilterId == filterItem.id ? Colors.black : Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }

  Widget _buildMaterialButtonIconOnly(IconData icons) {
    return MaterialButton(
      onPressed: () {},
      padding: const EdgeInsets.all(3.0),
      minWidth: 40,
      height: 0,
      color: customBlack.shade700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      textColor: Colors.white,
      child: Icon(icons),
    );
  }
}
