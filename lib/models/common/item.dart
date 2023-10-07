import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/content_details.dart';
import 'package:live_sync_flutter_app/models/common/snippet.dart';
import 'package:live_sync_flutter_app/models/common/statistics.dart';
import 'package:live_sync_flutter_app/models/common/topic_details.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  final String etag;
  final String id;
  final String kind;
  final ContentDetails? contentDetails;
  final Snippet? snippet;
  final Statistics? statistics;
  final TopicDetails? topicDetails;

  const Item ({
    required this.etag,
    required this.id,
    required this.kind,
    required this.contentDetails,
    required this.snippet,
    required this.statistics,
    required this.topicDetails,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      contentDetails: json['contentDetails'] != null ? ContentDetails.fromJson(json['contentDetails']) : null,
      snippet: json['snippet'] != null ? Snippet.fromJson(json['snippet']) : null,
      statistics: json['statistics'] != null ? Statistics.fromJson(json['statistics']) : null,
      topicDetails: json['topicDetails'] != null ? TopicDetails.fromJson(json['topicDetails']) : null,
    );
  }
}