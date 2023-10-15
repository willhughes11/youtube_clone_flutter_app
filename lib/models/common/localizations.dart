import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/localization_info.dart';

@JsonSerializable(explicitToJson: true)
class Localizations {
  final LocalizationInfo? enUs;
  final LocalizationInfo? esEs;

  const Localizations({
    required this.enUs,
    required this.esEs,
  });

  factory Localizations.fromJson(Map<String, dynamic> json) {
    return Localizations(
      enUs: json['en_US'] != null ? LocalizationInfo.fromJson(json['en_US']) : null,
      esEs: json['es_ES'] != null ? LocalizationInfo.fromJson(json['es_ES']) : null,
    );
  }
}