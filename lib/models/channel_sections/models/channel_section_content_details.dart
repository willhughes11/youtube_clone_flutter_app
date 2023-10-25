import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ChannelSectionContentDetails {
  final List<String>? playlists;
  final List<String>? channels;

  const ChannelSectionContentDetails({
    required this.playlists,
    required this.channels,
  });

  factory ChannelSectionContentDetails.fromJson(Map<String, dynamic> json) {
    List<String> playlists = [];
    var playlistsFromJson = json['playlists'];
    if (playlistsFromJson != null && playlistsFromJson is List) {
      playlists = List<String>.from(playlistsFromJson);
    }

    List<String> channels = [];
    var channelsFromJson = json['channels'];
    if (channelsFromJson != null && channelsFromJson is List) {
      channels = List<String>.from(channelsFromJson);
    }

    return ChannelSectionContentDetails(
      playlists: playlists,
      channels: channels,
    );
  }
}
