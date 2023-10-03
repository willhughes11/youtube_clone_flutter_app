import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class Thumbnails {
  final ThumbnailInfo default_;
  final ThumbnailInfo high;
  final ThumbnailInfo? maxres;
  final ThumbnailInfo medium;
  final ThumbnailInfo? standard;


  const Thumbnails ({
    required this.default_,
    required this.high,
    required this.maxres,
    required this.medium,
    required this.standard,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) {
    
    return Thumbnails(
      default_: ThumbnailInfo.fromJson(json['default']),
      high: ThumbnailInfo.fromJson(json['high']),
      maxres: json['maxres'] != null ? ThumbnailInfo.fromJson(json['maxres']) : null,
      medium: ThumbnailInfo.fromJson(json['medium']),
      standard: json['standard'] != null ? ThumbnailInfo.fromJson(json['standard']) : null,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ThumbnailInfo {
  final int height;
  final String url;
  final int width;

  const ThumbnailInfo ({
    required this.height,
    required this.url,
    required this.width,
  });

  factory ThumbnailInfo.fromJson(Map<String, dynamic> json) {
    return ThumbnailInfo(
      height: json['height'],
      url: json['url'],
      width: json['width'],
    );
  }
}