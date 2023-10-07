import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ContentDetails {
  final String caption;
  final Object contentRating;
  final String definition;
  final String dimension;
  final String duration;
  final bool? licensedContent;
  final String projection;


  const ContentDetails ({
    required this.caption,
    required this.contentRating,
    required this.definition,
    required this.dimension,
    required this.duration,
    required this.licensedContent,
    required this.projection,
  });

  factory ContentDetails.fromJson(Map<String, dynamic> json) {
    return ContentDetails(
      caption: json['caption'],
      contentRating: json['contentRating'],
      definition: json['definition'],
      dimension: json['dimension'],
      duration: json['duration'],
      licensedContent: json['licensedContent'],
      projection: json['projection'],
    );
  }
}