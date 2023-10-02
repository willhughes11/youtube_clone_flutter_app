import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Statistics {
  final String commentCount;
  final String likeCount;
  final String viewCount;

  const Statistics ({
    required this.commentCount,
    required this.likeCount,
    required this.viewCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      commentCount: json['commentCount'],
      likeCount: json['likeCount'],
      viewCount: json['viewCount'],
    );
  }
}