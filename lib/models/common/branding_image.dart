import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class BrandingImage {
  final String bannerExternalUrl;

  const BrandingImage({
    required this.bannerExternalUrl,
  });

  factory BrandingImage.fromJson(Map<String, dynamic> json) {
    return BrandingImage(
      bannerExternalUrl: json['bannerExternalUrl'],
    );
  }
}