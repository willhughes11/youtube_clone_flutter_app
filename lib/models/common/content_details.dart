import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/related_playlists.dart';

@JsonSerializable(explicitToJson: true)
class ContentDetails {
  final String? caption;
  final Object? contentRating;
  final String? definition;
  final String? dimension;
  final String? duration;
  final bool? licensedContent;
  final String? projection;
  final RelatedPlaylists? relatedPlaylists;


  const ContentDetails ({
    required this.caption,
    required this.contentRating,
    required this.definition,
    required this.dimension,
    required this.duration,
    required this.licensedContent,
    required this.projection,
    required this.relatedPlaylists,
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
      relatedPlaylists: json['relatedPlaylists'] != null ? RelatedPlaylists.fromJson(json['relatedPlaylists']) : null,
    );
  }
}