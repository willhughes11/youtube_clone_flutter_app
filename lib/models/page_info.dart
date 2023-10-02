import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PageInfo {
  final int resultsPerPage;
  final int totalResults;

  const PageInfo ({
    required this.resultsPerPage,
    required this.totalResults,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      resultsPerPage: json['resultsPerPage'],
      totalResults: json['totalResults'],
    );
  }
}