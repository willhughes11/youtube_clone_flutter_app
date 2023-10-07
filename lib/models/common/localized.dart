import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Localized {
  final String? description;
  final String title;


  const Localized ({
    required this.description,
    required this.title,
  });

  factory Localized.fromJson(Map<String, dynamic> json) {
    return Localized(
      description: json['description'],
      title: json['title'],
    );
  }
}