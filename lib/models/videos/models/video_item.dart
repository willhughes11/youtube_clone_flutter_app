import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/statistics.dart';
import 'package:youtube_clone_flutter_app/models/common/topic_details.dart';
import 'package:youtube_clone_flutter_app/models/videos/models/video_content_details.dart';
import 'package:youtube_clone_flutter_app/models/videos/models/video_snippet.dart';

@JsonSerializable(explicitToJson: true)
class VideoItem {
  final String etag;
  final String id;
  final String kind;
  final VideoContentDetails? contentDetails;
  final VideoSnippet? snippet;
  final Statistics? statistics;
  final TopicDetails? topicDetails;

  const VideoItem({
    required this.etag,
    required this.id,
    required this.kind,
    required this.contentDetails,
    required this.snippet,
    required this.statistics,
    required this.topicDetails,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      contentDetails: json['contentDetails'] != null
          ? VideoContentDetails.fromJson(json['contentDetails'])
          : null,
      snippet: json['snippet'] != null
          ? VideoSnippet.fromJson(json['snippet'])
          : null,
      statistics: json['statistics'] != null
          ? Statistics.fromJson(json['statistics'])
          : null,
      topicDetails: json['topicDetails'] != null
          ? TopicDetails.fromJson(json['topicDetails'])
          : null,
    );
  }
}
