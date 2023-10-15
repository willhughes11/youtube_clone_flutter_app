import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/channel/models/channel_item.dart';
import 'package:youtube_clone_flutter_app/models/common/page_info.dart';

@JsonSerializable()
class Channel {
  String etag;
  String kind;
  PageInfo pageInfo;
  List<ChannelItem> items;

  Channel(
      {required this.etag,
      required this.kind,
      required this.pageInfo,
      required this.items});

  factory Channel.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<ChannelItem> itemList =
        itemListFromJson.map((i) => ChannelItem.fromJson(i)).toList();
    return Channel(
      etag: json['etag'],
      kind: json['kind'],
      pageInfo: PageInfo.fromJson(json["pageInfo"]),
      items: itemList,
    );
  }
}
