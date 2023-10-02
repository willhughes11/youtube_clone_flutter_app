import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/content_details.dart';
import 'package:live_sync_flutter_app/models/snippet.dart';
import 'package:live_sync_flutter_app/models/statistics.dart';
import 'package:live_sync_flutter_app/models/topic_details.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  final String etag;
  final String id;
  final String kind;
  final ContentDetails contentDetails;
  final Snippet snippet;
  final Statistics statistics;
  final TopicDetails topicDetails;

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
      contentDetails: ContentDetails.fromJson(json['contentDetails']),
      snippet: Snippet.fromJson(json['snippet']),
      statistics: Statistics.fromJson(json['statistics']),
      topicDetails: TopicDetails.fromJson(json['topicDetails'])
    );
  }
}