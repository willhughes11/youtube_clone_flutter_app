import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:http/http.dart' as http;

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

class _HomePageState extends State<HomePage> {
  late Future<PopularVideos> futurePopularVideos;

  @override
  void initState() {
    super.initState();
    futurePopularVideos = fetchPopularVideos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: FutureBuilder<PopularVideos>(
          future: futurePopularVideos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final popularVideos = snapshot.data;
              return buildYourUI(popularVideos);
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            return const CircularProgressIndicator();
          },
        )),
      ),
    );
  }
}

Widget buildYourUI(PopularVideos? popularVideos) {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        // Add widgets here to display the API data in a Column
        if (popularVideos != null)
          for (var video in popularVideos.items)
            ListTile(
              
              leading: Image.network(
                video.snippet.thumbnails.default_
                    .url, // Replace with your image URL
                width: 48, // Adjust the width as needed
                height: 48, // Adjust the height as needed
              ),
              title: Text(video.snippet.title),
              subtitle: Text(
                  '${video.snippet.channelTitle} • ${video.statistics.viewCount} • ${video.snippet.publishedAt}'),
              onTap: (){
                debugPrint(video.id);
              },
            ),
      ],
    ),
  );
}
