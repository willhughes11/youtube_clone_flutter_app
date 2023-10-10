import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/page_info.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';

@JsonSerializable()
class PopularVideos {
  final String etag;
  final String kind;
  final String? nextPageToken;
  final String? prevPageToken;
  final PageInfo? pageInfo;
  final List<Item> items;

  const PopularVideos ({
    required this.etag,
    required this.kind,
    required this.nextPageToken,
    required this.prevPageToken,
    required this.pageInfo,
    required this.items
  });

  factory PopularVideos.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<Item> itemList = itemListFromJson.map((i) => Item.fromJson(i)).toList();
    return PopularVideos(
      etag: json['etag'],
      kind: json['kind'],
      nextPageToken: json['nextPageToken'],
      prevPageToken: json['prevPageToken'],
      pageInfo: PageInfo.fromJson(json["pageInfo"]),
      items: itemList
    );
  }
}