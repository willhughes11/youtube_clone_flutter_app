import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ChannelSectionSnippet {
  final String channelId;
  final int position;
  final String type;
  
  const ChannelSectionSnippet ({
    required this.channelId,
    required this.position,
    required this.type,
  });

  factory ChannelSectionSnippet.fromJson(Map<String, dynamic> json) {
    return ChannelSectionSnippet(
      channelId: json['channelId'],
      position: json['position'],
      type: json['type'],
    );
  }
}