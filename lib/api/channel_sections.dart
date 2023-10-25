import 'package:http/http.dart' as http;
import 'package:youtube_clone_flutter_app/models/channel_sections/channel_sections.dart';
import 'dart:convert';

Future<ChannelSections> fetchChannelSectionsByChannelId(String baseUrl, String channelId) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/channelSections/channel/$channelId'
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return ChannelSections.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load channel by ID');
  }
}
