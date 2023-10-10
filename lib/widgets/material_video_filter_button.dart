import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';

class MaterialVideoFilterButton extends StatelessWidget {
  final String baseUrl;
  final String selectedFilterId;
  final Item filterItem;
  final Function(String) updateSelectedFilterCategory;
  final Function(String, String) fetchAndSetPopularVideos;

  const MaterialVideoFilterButton(
      {super.key,
      required this.baseUrl,
      required this.selectedFilterId,
      required this.filterItem,
      required this.updateSelectedFilterCategory,
      required this.fetchAndSetPopularVideos});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        debugPrint(filterItem.id);
        updateSelectedFilterCategory(filterItem.id);
        fetchAndSetPopularVideos(baseUrl, filterItem.id);
      },
      padding: const EdgeInsets.all(8.0),
      minWidth: 50,
      height: 0,
      color: selectedFilterId == filterItem.id
          ? Colors.white
          : customBlack.shade600,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        filterItem.snippet!.title,
        style: TextStyle(
          color:
              selectedFilterId == filterItem.id ? Colors.black : Colors.white,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
