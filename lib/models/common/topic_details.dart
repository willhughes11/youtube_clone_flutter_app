import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class TopicDetails {
  final List<String> topicCategories;
  final List<String>? topicIds;

  const TopicDetails({
    required this.topicCategories,
    required this.topicIds,
  });

  factory TopicDetails.fromJson(Map<String, dynamic> json) {
    var topicCategoriesFromJson = json['topicCategories'];
    List<String> topicCategories = List<String>.from(topicCategoriesFromJson);

    List<String> topicIds = [];
    var topicIdsFromJson = json['topicIds'];
    if (topicIdsFromJson != null && topicIdsFromJson is List) {
      topicIds = List<String>.from(topicIdsFromJson);
    }

    return TopicDetails(
      topicCategories: topicCategories,
      topicIds: topicIds,
    );
  }
}
