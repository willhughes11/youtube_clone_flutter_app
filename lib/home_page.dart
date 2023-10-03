import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/custom/material_colors.dart';
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:http/http.dart' as http;
import 'package:get_time_ago/get_time_ago.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<PopularVideos> fetchPopularVideos() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/videos/popular'));

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

Future<ChannelThumbnails> fetchChannelThumbnails(String channelId) async {
  final response = await http
      .get(Uri.parse('http://localhost:8080/channel/$channelId/thumbnails'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ChannelThumbnails.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load channel thumbnails');
  }
}

class _HomePageState extends State<HomePage> {
  late Future<PopularVideos> futurePopularVideos;

  @override
  void initState() {
    super.initState();
    futurePopularVideos = fetchPopularVideos();
  }

  Future<Map<String, ChannelThumbnails>> fetchChannelThumbnailsForPopularVideos(
      PopularVideos popularVideos) async {
    final Map<String, ChannelThumbnails> channelThumbnailsMap = {};

    for (var video in popularVideos.items) {
      final response = await http.get(Uri.parse(
          'http://localhost:8080/channel/${video.snippet.channelId}/thumbnails'));

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
                      return scrollableVideoMiniPlayer(
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

Widget scrollableVideoMiniPlayer(PopularVideos? popularVideos,
    Map<String, ChannelThumbnails>? channelThumbnailsMap) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Add widgets here to display the API data in a Column
        if (popularVideos != null)
          for (var video in popularVideos.items)
            TappableCard(
                videoThumbnailUrl: video.snippet.thumbnails.maxres?.url ??
                    video.snippet.thumbnails.high.url,
                title: video.snippet.title,
                channelTitle: video.snippet.channelTitle,
                viewCount: video.statistics.viewCount,
                publishedAt: video.snippet.publishedAt,
                videoId: video.id,
                channelThumbnailUrl:
                    channelThumbnailsMap![video.snippet.channelId]
                            ?.thumbnails
                            .high
                            .url ??
                        '')
      ],
    ),
  );
}

class TappableCard extends StatelessWidget {
  final String videoThumbnailUrl;
  final String title;
  final String channelTitle;
  final String viewCount;
  final String publishedAt;
  final String videoId;
  final String channelThumbnailUrl;

  const TappableCard(
      {super.key,
      required this.videoThumbnailUrl,
      required this.title,
      required this.channelTitle,
      required this.viewCount,
      required this.publishedAt,
      required this.videoId,
      required this.channelThumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle tap event here
        debugPrint(videoId);
      },
      child: Card(
        color: customBlack.shade800,
        child: Column(
          children: [
            Image.network(videoThumbnailUrl),
            ListTile(
              contentPadding: const EdgeInsets.all(8.0),
              leading: Container(
                padding: const EdgeInsets.all(0.0),
                child: ClipOval(
                  child: Image.network(
                    channelThumbnailUrl,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
              subtitle: Wrap(children: [
                Text(
                  channelTitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: const Text(
                    '•',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                Text(
                  '${formatNumber(viewCount)} views',
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: const Text(
                    '•',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                    ),
                  ),
                ),
                Text(
                  calculateRelativeTime(publishedAt),
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600),
                ),
              ]),
              trailing: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onTap: () {
                debugPrint(videoId);
              },
            ),
          ],
        ),
      ),
    );
  }
}

String formatNumber(String numberString) {
  // Parse the string to an integer
  int number = int.tryParse(numberString) ?? 0;

  if (number >= 1000000000) {
    double result = number / 1000000000;
    return '${result.toStringAsFixed(1)}B';
  } else if (number >= 1000000) {
    double result = number / 1000000;
    return '${result.toStringAsFixed(1)}M';
  } else if (number >= 1000) {
    double result = number / 1000;
    return '${result.toStringAsFixed(1)}K';
  } else {
    return number.toString();
  }
}

class CustomMessages implements Messages {
  @override
  String prefixAgo() => '';

  @override
  String suffixAgo() => 'ago';

  @override
  String secsAgo(int seconds) => '$seconds seconds';

  @override
  String minAgo(int minutes) => '1 minute';

  @override
  String minsAgo(int minutes) => '$minutes minutes';

  @override
  String hourAgo(int minutes) => '1 hour';

  @override
  String hoursAgo(int hours) => '$hours hours';

  @override
  String dayAgo(int hours) => '1 day';

  @override
  String daysAgo(int days) => '$days days';

  @override
  String wordSeparator() => ' ';
}

String calculateRelativeTime(String timestamp) {
  GetTimeAgo.setCustomLocaleMessages('en', CustomMessages());
  var convertedTimestamp =
      DateTime.parse(timestamp); // Converting into [DateTime] object
  var result = GetTimeAgo.parse(convertedTimestamp);
  return result;
}
