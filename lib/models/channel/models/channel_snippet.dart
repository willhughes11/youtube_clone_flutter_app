import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/localization_info.dart';
import 'package:youtube_clone_flutter_app/models/common/thumbnails.dart';

@JsonSerializable(explicitToJson: true)
class ChannelSnippet {
  final String title;
  final String? customUrl;
  final String? description;
  final LocalizationInfo localized;
  final Thumbnails thumbnails;
  final String publishedAt;

  const ChannelSnippet({
    required this.description,
    required this.title,
    required this.localized,
    required this.thumbnails,
    required this.customUrl,
    required this.publishedAt,
  });

  factory ChannelSnippet.fromJson(Map<String, dynamic> json) {
    return ChannelSnippet(
      description: json['description'],
      title: json['title'],
      localized: LocalizationInfo.fromJson(json['localized']),
      thumbnails: Thumbnails.fromJson(json['thumbnails']),
      customUrl: json['customUrl'],
      publishedAt: json['publishedAt'],
    );
  }
}
