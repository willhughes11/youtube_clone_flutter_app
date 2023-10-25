import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/video_categories/models/video_category_snippet.dart';

@JsonSerializable(explicitToJson: true)
class VideoCategoryItem {
  final String etag;
  final String id;
  final String kind;
  final VideoCategorySnippet snippet;

  const VideoCategoryItem ({
    required this.etag,
    required this.id,
    required this.kind,
    required this.snippet,
  });

  factory VideoCategoryItem.fromJson(Map<String, dynamic> json) {
    return VideoCategoryItem(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      snippet: VideoCategorySnippet.fromJson(json['snippet']),
    );
  }
}