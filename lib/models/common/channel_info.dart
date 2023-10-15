import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ChannelInfo {
  final String? country;
  final String? defaultLanguage;
  final String? description;
  final String? keywords;
  final String title;
  final String? unsubscribedTrailer;


  const ChannelInfo ({
    required this.country,
    required this.defaultLanguage,
    required this.description,
    required this.keywords,
    required this.title,
    required this.unsubscribedTrailer,
  });

  factory ChannelInfo.fromJson(Map<String, dynamic> json) {
    return ChannelInfo(
      country: json['country'],
      defaultLanguage: json['defaultLanguage'],
      description: json['description'],
      keywords: json['keywords'],
      title: json['title'],
      unsubscribedTrailer: json['unsubscribedTrailer'],
    );
  }
}