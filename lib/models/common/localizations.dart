import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/localization_info.dart';

@JsonSerializable(explicitToJson: true)
class Localizations {
  final LocalizationInfo enUs;
  final LocalizationInfo esEs;

  const Localizations({
    required this.enUs,
    required this.esEs,
  });

  factory Localizations.fromJson(Map<String, dynamic> json) {
    return Localizations(
      enUs: json['en_US'],
      esEs: json['es_ES'],
    );
  }
}