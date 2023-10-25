import 'package:http/http.dart' as http;
import 'package:youtube_clone_flutter_app/models/channels/channels.dart';

import 'dart:convert';

Future<Channels> fetchChannelById(String baseUrl, String channelId) async {
  final parsedUrl = Uri.parse(baseUrl);
  final requestUrl = parsedUrl.replace(
    path: '/api/v1/channels',
    queryParameters: {"id": channelId},
  );

  final response = await http.get(Uri.parse(requestUrl.toString()));

  if (response.statusCode == 200) {
    return Channels.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load channel by ID');
  }
}
