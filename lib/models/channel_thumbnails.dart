import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/thumbnails.dart';

@JsonSerializable()
class ChannelThumbnails {
  final String etag;
  final String id;
  final String kind;
  final Thumbnails thumbnails;

  const ChannelThumbnails ({
    required this.etag,
    required this.id,
    required this.kind,
    required this.thumbnails
  });

  factory ChannelThumbnails.fromJson(Map<String, dynamic> json) {
    return ChannelThumbnails(
      etag: json['etag'],
      id: json['id'],
      kind: json['kind'],
      thumbnails: Thumbnails.fromJson(json["thumbnails"]),
    );
  }
}