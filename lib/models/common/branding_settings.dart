import 'package:json_annotation/json_annotation.dart';
import 'package:live_sync_flutter_app/models/common/branding_image.dart';
import 'package:live_sync_flutter_app/models/common/channel_info.dart';

@JsonSerializable(explicitToJson: true)
class BrandingSettings {
  final ChannelInfo? channel;
  final BrandingImage? image;

  const BrandingSettings({
    required this.channel,
    required this.image,
  });

  factory BrandingSettings.fromJson(Map<String, dynamic> json) {
    return BrandingSettings(
      channel: json['channel'] != null ? ChannelInfo.fromJson(json['channel']) : null,
      image: json['image'] != null ? BrandingImage.fromJson(json['image']) : null,
    );
  }
}