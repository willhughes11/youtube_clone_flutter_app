import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/localization_info.dart';
import 'package:youtube_clone_flutter_app/models/common/thumbnails.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistSnippet{
  final String channelId;
  final String channelTitle;
  final String description;
  final String publishedAt;
  final String title;
  final LocalizationInfo localized;
  final Thumbnails thumbnails;

  const PlaylistSnippet ({
    required this.channelId,
    required this.channelTitle,
    required this.description,
    required this.publishedAt,
    required this.title,
    required this.localized,
    required this.thumbnails,
  });

  factory PlaylistSnippet.fromJson(Map<String, dynamic> json) {
    return PlaylistSnippet(
      channelId: json['channelId'],
      channelTitle: json['channelTitle'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      title: json['title'],
      localized: LocalizationInfo.fromJson(json['localized']),
      thumbnails: Thumbnails.fromJson(json['thumbnails']),
    );
  }
}