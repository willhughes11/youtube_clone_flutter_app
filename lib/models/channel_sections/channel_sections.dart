import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/models/channel_section_item.dart';

@JsonSerializable()
class ChannelSections {
  String etag;
  String kind;
  List<ChannelSectionItem> items;

  ChannelSections(
      {required this.etag, required this.kind, required this.items});

  factory ChannelSections.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<ChannelSectionItem> itemList =
        itemListFromJson.map((i) => ChannelSectionItem.fromJson(i)).toList();
    return ChannelSections(
      etag: json['etag'],
      kind: json['kind'],
      items: itemList,
    );
  }
}
