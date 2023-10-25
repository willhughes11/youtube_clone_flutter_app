import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/models/channel_section_content_details.dart';
import 'package:youtube_clone_flutter_app/models/channel_sections/models/channel_section_snippet.dart';

@JsonSerializable(explicitToJson: true)
class ChannelSectionItem {
  final String etag;
  final String id;
  final String kind;
  final ChannelSectionSnippet snippet;
  final ChannelSectionContentDetails? contentDetails;

  const ChannelSectionItem({
    required this.etag,
    required this.id,
    required this.kind,
    required this.snippet,
    required this.contentDetails,
  });

  factory ChannelSectionItem.fromJson(Map<String, dynamic> json) {
    return ChannelSectionItem(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      snippet: ChannelSectionSnippet.fromJson(
        json['snippet'],
      ),
      contentDetails: json['contentDetails'] != null
          ? ChannelSectionContentDetails.fromJson(
              json['contentDetails'],
            )
          : null,
    );
  }
}
