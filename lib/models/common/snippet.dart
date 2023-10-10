import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/localized.dart';
import 'package:live_sync_flutter_app/models/common/thumbnails.dart';

@JsonSerializable(explicitToJson: true)
class Snippet {
  final String? categoryId;
  final String channelId;
  final String? channelTitle;
  final String? defaultAudioLanguage;
  final String? defaultLanguage;
  final String? description;
  final String? liveBroadcastContent;
  final String? publishedAt;
  final String title;
  final Localized? loacalized;
  final Thumbnails? thumbnails;
  final Thumbnails? channelThumbnails;
  final bool? assignable;
  
  const Snippet ({
    required this.categoryId,
    required this.channelId,
    required this.channelTitle,
    required this.defaultAudioLanguage,
    required this.defaultLanguage,
    required this.description,
    required this.liveBroadcastContent,
    required this.publishedAt,
    required this.title,
    required this.loacalized,
    required this.thumbnails,
    required this.channelThumbnails,
    required this.assignable,
  });

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
      categoryId: json['categoryId'],
      channelId: json['channelId'],
      channelTitle: json['channelTitle'],
      defaultAudioLanguage: json['defaultAudioLanguage'],
      defaultLanguage: json['defaultLanguage'],
      description: json['description'],
      liveBroadcastContent: json['liveBroadcastContent'],
      publishedAt: json['publishedAt'],
      title: json['title'],
      loacalized: json['localized'] != null ? Localized.fromJson(json['localized']) : null,
      thumbnails: json['thumbnails'] != null ? Thumbnails.fromJson(json['thumbnails']) : null,
      channelThumbnails: json['channelThumbnails'] != null ? Thumbnails.fromJson(json['channelThumbnails']) : null,
      assignable: json['assignable']
    );
  }
}