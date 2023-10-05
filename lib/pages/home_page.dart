import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/widgets/popular_video_browser.dart';

import 'dart:convert';
import 'dart:io';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<PopularVideos> fetchPopularVideos(String baseUrl) async {
  final response =
      await http.get(Uri.parse('http://$baseUrl:8080/videos/popular'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PopularVideos.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load popular videos');
  }
}

class _HomePageState extends State<HomePage> {
  late Future<PopularVideos> futurePopularVideos;
  late String baseUrl;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      baseUrl = '10.0.2.2';
    } else {
      baseUrl = 'localhost';
    }


    futurePopularVideos = fetchPopularVideos(baseUrl);
  }

  Future<Map<String, ChannelThumbnails>> fetchChannelThumbnailsForPopularVideos(
      PopularVideos popularVideos) async {
    final Map<String, ChannelThumbnails> channelThumbnailsMap = {};

    for (var video in popularVideos.items) {
      final response = await http.get(Uri.parse(
          'http://$baseUrl:8080/channel/${video.snippet.channelId}/thumbnails'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final channelThumbnails = ChannelThumbnails.fromJson(data);
        channelThumbnailsMap[video.snippet.channelId] = channelThumbnails;
      } else {
        throw Exception('Failed to load channel thumbnails');
      }
    }

    return channelThumbnailsMap;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: customBlack.shade800,
        body: Center(
          child: FutureBuilder<PopularVideos>(
            future: futurePopularVideos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final popularVideos = snapshot.data;

                if (popularVideos == null || popularVideos.items.isEmpty) {
                  return const Text('No popular videos available');
                }

                final channelThumbnailsFuture =
                    fetchChannelThumbnailsForPopularVideos(popularVideos);

                return FutureBuilder<Map<String, ChannelThumbnails>>(
                  future: channelThumbnailsFuture,
                  builder: (context, channelSnapshot) {
                    if (channelSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (channelSnapshot.hasError) {
                      return Center(
                        child: Text('Error: ${channelSnapshot.error}'),
                      );
                    } else if (channelSnapshot.hasData) {
                      final channelThumbnailsMap = channelSnapshot.data;
                      return popularVideoBrowser(
                        popularVideos,
                        channelThumbnailsMap,
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}