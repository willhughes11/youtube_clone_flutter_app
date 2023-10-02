import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/localized.dart';
import 'package:live_sync_flutter_app/models/thumbnails.dart';

@JsonSerializable(explicitToJson: true)
class Snippet {
  final String categoryId;
  final String channelId;
  final String channelTitle;
  final String? defaultAudioLanguage;
  final String? defaultLanguage;
  final String description;
  final String liveBroadcastContent;
  final String publishedAt;
  final String title;
  final Localized loacalized;
  final Thumbnails thumbnails;
  
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
    required this.thumbnails
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
      loacalized: Localized.fromJson(json['localized']),
      thumbnails: Thumbnails.fromJson(json['thumbnails'])
    );
  }
}