import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/page_info.dart';
import 'package:live_sync_flutter_app/models/common/item.dart';

@JsonSerializable()
class Channel {
  String etag;
  String kind;
  PageInfo? pageInfo;
  List<Item> items;

  Channel(
      {required this.etag,
      required this.kind,
      required this.pageInfo,
      required this.items});

  factory Channel.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<Item> itemList =
        itemListFromJson.map((i) => Item.fromJson(i)).toList();
    return Channel(
        etag: json['etag'],
        kind: json['kind'],
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
        items: itemList);
  }
}
