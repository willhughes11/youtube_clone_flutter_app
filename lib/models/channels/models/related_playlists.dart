import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class RelatedPlaylists {
  final String uploads;

  const RelatedPlaylists({
    required this.uploads,
  });

  factory RelatedPlaylists.fromJson(Map<String, dynamic> json) {
    return RelatedPlaylists(
      uploads: json['uploads'],
    );
  }
}