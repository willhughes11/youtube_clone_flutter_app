import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/page_info.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';

@JsonSerializable()
class PopularVideos {
  String etag;
  String kind;
  String? nextPageToken;
  String? prevPageToken;
  PageInfo? pageInfo;
  List<Item> items;

  PopularVideos(
      {required this.etag,
      required this.kind,
      required this.nextPageToken,
      required this.prevPageToken,
      required this.pageInfo,
      required this.items});

  // Method to update object properties from API data
  void updateFromApiData(PopularVideos apiData, [bool? refreshData]) {
    etag = apiData.etag;
    kind = apiData.kind;
    nextPageToken = apiData.nextPageToken;
    prevPageToken = apiData.prevPageToken;
    pageInfo = apiData.pageInfo;
    if (refreshData == true) {
      items = apiData.items;
    } else {
      items.addAll(apiData.items);
    }
  }

  factory PopularVideos.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<Item> itemList =
        itemListFromJson.map((i) => Item.fromJson(i)).toList();
    return PopularVideos(
        etag: json['etag'],
        kind: json['kind'],
        nextPageToken: json['nextPageToken'],
        prevPageToken: json['prevPageToken'],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: itemList);
  }
}
