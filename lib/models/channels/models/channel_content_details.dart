import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/channels/models/related_playlists.dart';

@JsonSerializable(explicitToJson: true)
class ChannelContentDetails {
  final RelatedPlaylists? relatedPlaylists;

  const ChannelContentDetails ({
    required this.relatedPlaylists,
  });

  factory ChannelContentDetails.fromJson(Map<String, dynamic> json) {
    return ChannelContentDetails(
      relatedPlaylists: json['relatedPlaylists'] != null ? RelatedPlaylists.fromJson(json['relatedPlaylists']) : null,
    );
  }
}