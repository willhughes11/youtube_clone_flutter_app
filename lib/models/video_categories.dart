import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/item.dart';

@JsonSerializable()
class VideoCategories {
  final String etag;
  final String kind;
  final List<Item> items;

  const VideoCategories ({
    required this.etag,
    required this.kind,
    required this.items
  });

  factory VideoCategories.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<Item> itemList = itemListFromJson.map((i) => Item.fromJson(i)).toList();
    return VideoCategories(
      etag: json['etag'],
      kind: json['kind'],
      items: itemList
    );
  }
}