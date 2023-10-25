import 'package:json_annotation/json_annotation.dart';
import 'package:youtube_clone_flutter_app/models/common/page_info.dart';
import 'package:youtube_clone_flutter_app/models/playlists/models/playlist_item.dart';

@JsonSerializable()
class Playlists {
  String etag;
  String kind;
  List<PlaylistItem> items;
  PageInfo pageInfo;

  Playlists({
    required this.etag,
    required this.kind,
    required this.items,
    required this.pageInfo,
  });

  factory Playlists.fromJson(Map<String, dynamic> json) {
    var itemListFromJson = json['items'] as List;
    List<PlaylistItem> itemList =
        itemListFromJson.map((i) => PlaylistItem.fromJson(i)).toList();

    return Playlists(
      etag: json['etag'],
      kind: json['kind'],
      pageInfo: PageInfo.fromJson(json["pageInfo"]),
      items: itemList,
    );
  }
}
