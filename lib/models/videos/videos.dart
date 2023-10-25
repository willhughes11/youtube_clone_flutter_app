import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/videos/models/video_item.dart';
import 'package:youtube_clone_flutter_app/models/common/page_info.dart';

@JsonSerializable()
class Videos {
  String etag;
  String kind;
  String? nextPageToken;
  String? prevPageToken;
  String? regionCode;
  PageInfo pageInfo;
  List<VideoItem> items;

  Videos({
    required this.etag,
    required this.kind,
    required this.nextPageToken,
    required this.prevPageToken,
    required this.pageInfo,
    required this.items,
    required this.regionCode,
  });

  // Method to update object properties from API data
  void updateFromApiData(Videos apiData, [bool? refreshData]) {
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

  factory Videos.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<VideoItem> itemList =
        itemListFromJson.map((i) => VideoItem.fromJson(i)).toList();
    return Videos(
      etag: json['etag'],
      kind: json['kind'],
      nextPageToken: json['nextPageToken'],
      prevPageToken: json['prevPageToken'],
      regionCode: json['regionCode'],
      pageInfo: PageInfo.fromJson(json["pageInfo"]),
      items: itemList,
    );
  }
}
