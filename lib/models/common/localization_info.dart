import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class LocalizationInfo {
  final String? description;
  final String? title;

  const LocalizationInfo({
    required this.description,
    required this.title
  });

  factory LocalizationInfo.fromJson(Map<String, dynamic> json) {
    return LocalizationInfo(
      description: json['description'],
      title: json['title'],
    );
  }
}