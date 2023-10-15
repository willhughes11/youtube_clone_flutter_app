import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Status {
  final bool isLinked;
  final String longUploadStatus;
  final String privacyStatus;

  const Status({
    required this.isLinked,
    required this.longUploadStatus,
    required this.privacyStatus,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      isLinked: json['isLinked'],
      longUploadStatus: json['longUploadStatus'],
      privacyStatus: json['privacyStatus'],
    );
  }
}