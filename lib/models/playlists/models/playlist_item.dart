import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/status.dart';
import 'package:youtube_clone_flutter_app/models/playlists/models/playlist_content_details.dart';
import 'package:youtube_clone_flutter_app/models/playlists/models/playlist_snippet.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistItem {
  final String etag;
  final String id;
  final String kind;
  final PlaylistContentDetails contentDetails;
  final PlaylistSnippet snippet;
  final Status status;

  const PlaylistItem({
    required this.etag,
    required this.id,
    required this.kind,
    required this.contentDetails,
    required this.snippet,
    required this.status,
  });

  factory PlaylistItem.fromJson(Map<String, dynamic> json) {
    return PlaylistItem(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      contentDetails: PlaylistContentDetails.fromJson(json['contentDetails']),
      snippet: PlaylistSnippet.fromJson(json['snippet']),
      status: Status.fromJson(json['status']),
    );
  }
}
