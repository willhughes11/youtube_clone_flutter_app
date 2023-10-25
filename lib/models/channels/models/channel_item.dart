import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/channels/models/branding_settings.dart';
import 'package:youtube_clone_flutter_app/models/channels/models/channel_content_details.dart';
import 'package:youtube_clone_flutter_app/models/channels/models/channel_snippet.dart';
import 'package:youtube_clone_flutter_app/models/common/status.dart';
import 'package:youtube_clone_flutter_app/models/common/statistics.dart';
import 'package:youtube_clone_flutter_app/models/common/topic_details.dart';

@JsonSerializable(explicitToJson: true)
class ChannelItem {
  final String etag;
  final String id;
  final String kind;
  final ChannelContentDetails contentDetails;
  final ChannelSnippet snippet;
  final Statistics statistics;
  final TopicDetails topicDetails;
  final BrandingSettings brandingSettings;
  final Status status;

  const ChannelItem({
    required this.etag,
    required this.id,
    required this.kind,
    required this.contentDetails,
    required this.snippet,
    required this.statistics,
    required this.topicDetails,
    required this.brandingSettings,
    required this.status,
  });

  factory ChannelItem.fromJson(Map<String, dynamic> json) {
    return ChannelItem(
        etag: json['etag'],
        id: json['id'],
        kind: json['kind'],
        contentDetails: ChannelContentDetails.fromJson(json['contentDetails']),
        snippet: ChannelSnippet.fromJson(json['snippet']),
        statistics: Statistics.fromJson(json['statistics']),
        topicDetails: TopicDetails.fromJson(json['topicDetails']),
        brandingSettings: BrandingSettings.fromJson(json['brandingSettings']),
        status: Status.fromJson(json['status']),);
  }
}
