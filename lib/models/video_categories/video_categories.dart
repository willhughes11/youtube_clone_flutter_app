import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/video_categories/models/video_category_item.dart';

@JsonSerializable()
class VideoCategories {
  final String etag;
  final String kind;
  final List<VideoCategoryItem> items;

  const VideoCategories ({
    required this.etag,
    required this.kind,
    required this.items
  });

  factory VideoCategories.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<VideoCategoryItem> itemList = itemListFromJson.map((i) => VideoCategoryItem.fromJson(i)).toList();
    return VideoCategories(
      etag: json['etag'],
      kind: json['kind'],
      items: itemList,
    );
  }
}