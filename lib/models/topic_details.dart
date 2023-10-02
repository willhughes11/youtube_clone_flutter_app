import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class TopicDetails {
  final List<String> topicCategories;

  const TopicDetails ({
    required this.topicCategories,
  });

  factory TopicDetails.fromJson(Map<String, dynamic> json) {
    var topicCategoriesFromJson = json['topicCategories'];
    List<String> topicCategories = List<String>.from(topicCategoriesFromJson);
    return TopicDetails(
      topicCategories: topicCategories,
    );
  }
}