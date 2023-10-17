import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/localization_info.dart';
import 'package:youtube_clone_flutter_app/models/common/thumbnails.dart';

@JsonSerializable(explicitToJson: true)
class VideoSnippet {
  final String channelId;
  final String categoryId;
  final String channelTitle;
  final String? defaultAudioLanguage;
  final String? defaultLanguage;
  final String? description;
  final String liveBroadcastContent;
  final String publishedAt;
  final String title;
  final LocalizationInfo localized;
  final Thumbnails thumbnails;
  final Thumbnails? channelThumbnails;
  
  const VideoSnippet ({
    required this.categoryId,
    required this.channelId,
    required this.channelTitle,
    required this.defaultAudioLanguage,
    required this.defaultLanguage,
    required this.description,
    required this.liveBroadcastContent,
    required this.publishedAt,
    required this.title,
    required this.localized,
    required this.thumbnails,
    required this.channelThumbnails,
  });

  factory VideoSnippet.fromJson(Map<String, dynamic> json) {
    return VideoSnippet(
      categoryId: json['categoryId'],
      channelId: json['channelId'],
      channelTitle: json['channelTitle'],
      defaultAudioLanguage: json['defaultAudioLanguage'],
      defaultLanguage: json['defaultLanguage'],
      description: json['description'],
      liveBroadcastContent: json['liveBroadcastContent'],
      publishedAt: json['publishedAt'],
      title: json['title'],
      localized: LocalizationInfo.fromJson(json['localized']),
      thumbnails: Thumbnails.fromJson(json['thumbnails']),
      channelThumbnails: json['channelThumbnails'] != null ? Thumbnails.fromJson(json['channelThumbnails']) : null,
    );
  }
}