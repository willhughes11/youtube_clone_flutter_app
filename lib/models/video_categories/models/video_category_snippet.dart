import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class VideoCategorySnippet {
  final bool? assignable;
  final String channelId;
  final String title;
  
  const VideoCategorySnippet ({
    required this.assignable,
    required this.channelId,
    required this.title,
  });

  factory VideoCategorySnippet.fromJson(Map<String, dynamic> json) {
    return VideoCategorySnippet(
      assignable: json['assignable'],
      channelId: json['channelId'],
      title: json['title'],
    );
  }
}