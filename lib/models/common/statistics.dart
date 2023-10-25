import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Statistics {
  final String viewCount;
  final String? commentCount;
  final String? likeCount;
  final String? videoCount;
  final String? subscriberCount;
  

  const Statistics ({
    required this.viewCount,
    required this.commentCount,
    required this.likeCount,
    required this.videoCount,
    required this.subscriberCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      viewCount: json['viewCount'],
      commentCount: json['commentCount'],
      likeCount: json['likeCount'],
      videoCount: json['videoCount'],
      subscriberCount: json['subscriberCount'],
    );
  }
}