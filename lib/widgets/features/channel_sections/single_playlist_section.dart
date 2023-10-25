import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/api/playlists.dart';
import 'package:youtube_clone_flutter_app/models/playlists/playlists.dart';

class SinglePlaylistSection extends StatelessWidget {
  final String baseUrl;
  final String playlistId;
  const SinglePlaylistSection({
    super.key,
    required this.baseUrl,
    required this.playlistId,
  });

  Future<Playlists> fetchData() async {
    var data = await fetchPlaylistById(baseUrl, playlistId);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Playlists>(
        future: fetchData(),
        builder: (BuildContext context, AsyncSnapshot<Playlists> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text(
              'Data: ${snapshot.data!.items[0].snippet.title}',
              style: const TextStyle(
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}
