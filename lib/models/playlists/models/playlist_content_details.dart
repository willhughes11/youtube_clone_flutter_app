import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PlaylistContentDetails {
  final int itemCount;

  const PlaylistContentDetails ({
    required this.itemCount,
  });

  factory PlaylistContentDetails.fromJson(Map<String, dynamic> json) {
    return PlaylistContentDetails(
      itemCount: json['itemCount'],
    );
  }
}