import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';

class MaterialVideoFilterButton extends StatelessWidget {
  final String baseUrl;
  final String selectedVideoCategoryId;
  final Item categoryItem;
  final Function(String) updateSelectedVideoCategory;
  final Function(String, String) fetchAndSetPopularVideos;

  const MaterialVideoFilterButton(
      {super.key,
      required this.baseUrl,
      required this.selectedVideoCategoryId,
      required this.categoryItem,
      required this.updateSelectedVideoCategory,
      required this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        debugPrint(categoryItem.id);
        updateSelectedVideoCategory(categoryItem.id);
        fetchAndSetPopularVideos(baseUrl, categoryItem.id);
      },
      padding: const EdgeInsets.all(8.0),
      minWidth: 50,
      height: 0,
      color: selectedVideoCategoryId == categoryItem.id
          ? Colors.white
          : customBlack.shade600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        categoryItem.snippet!.title,
        style: TextStyle(
          color:
              selectedVideoCategoryId == categoryItem.id ? Colors.black : Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
