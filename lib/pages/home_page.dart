import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/api/channels.dart';
import 'package:live_sync_flutter_app/api/videos.dart';
import 'package:live_sync_flutter_app/models/channel_thumbnails.dart';
import 'package:live_sync_flutter_app/models/video_categories.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/widgets/tappable_card.dart';
import 'package:live_sync_flutter_app/widgets/video_filter_bar.dart';

import 'dart:io';

import 'package:live_sync_flutter_app/widgets/video_loading_spinner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedVideCategoryId = "0";
  late Future<VideoCategories> futureVideoCategories;
  late Future<PopularVideos> futurePopularVideos;
  late String baseUrl;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:8080';
    } else {
      baseUrl = 'http://localhost:8080';
    }

    futureVideoCategories = fetchVideoCategories(baseUrl);
    futurePopularVideos = fetchPopularVideos(baseUrl);
  }

  void updateSelectedVideoCategory(String videoCatgoryId) {
    setState(() {
      selectedVideCategoryId = videoCatgoryId;
    });
  }

  Future<void> fetchAndSetPopularVideos(
      String baseUrl, String categoryId) async {
    try {
      final newPopularVideos = fetchPopularVideos(baseUrl, categoryId);
      setState(() {
        futurePopularVideos = newPopularVideos;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: customBlack.shade800,
        body: Center(
          child: FutureBuilder<VideoCategories>(
            future: futureVideoCategories,
            builder: (context, categorySnapshot) {
              var categoryItems = categorySnapshot.data?.items ?? [];
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: customBlack.shade800,
                    floating: true,
                    flexibleSpace: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: VideoFilterBar(
                          selectedVideoCategoryId: selectedVideCategoryId,
                          categoryItems: categoryItems,
                          baseUrl: baseUrl,
                          updateSelectedVideoCategory:
                              updateSelectedVideoCategory,
                          fetchAndSetPopularVideos: fetchAndSetPopularVideos),
                    ),
                  ),
                  FutureBuilder<PopularVideos>(
                      future: futurePopularVideos,
                      builder: (context, popularVideosSnapshot) {
                        if (popularVideosSnapshot.hasData) {
                          final mostPopularVideos = popularVideosSnapshot.data;

                          if (mostPopularVideos == null ||
                              mostPopularVideos.items.isEmpty) {
                            return const Text('No popular videos available');
                          }

                          final channelThumbnailsFuture =
                              fetchChannelThumbnailsForPopularVideos(
                                  mostPopularVideos, baseUrl);

                          return FutureBuilder<Map<String, ChannelThumbnails>>(
                            future: channelThumbnailsFuture,
                            builder: (context, channelSnapshot) {
                              if (channelSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SliverToBoxAdapter(
                                  child: VideoLoadingSpinner(),
                                );
                              } else if (channelSnapshot.hasError) {
                                return SliverToBoxAdapter(
                                  child: Center(
                                    child:
                                        Text('Error: ${channelSnapshot.error}'),
                                  ),
                                );
                              } else if (channelSnapshot.hasData) {
                                final channelThumbnailsMap =
                                    channelSnapshot.data;
                                return SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      final videoItem =
                                          mostPopularVideos.items[index];
                                      return TappableCard(
                                        videoThumbnailUrl: videoItem.snippet!
                                                .thumbnails?.maxres?.url ??
                                            videoItem
                                                .snippet!.thumbnails!.high.url,
                                        title: videoItem.snippet!.title,
                                        channelTitle:
                                            videoItem.snippet!.channelTitle!,
                                        viewCount:
                                            videoItem.statistics!.viewCount,
                                        publishedAt:
                                            videoItem.snippet!.publishedAt!,
                                        videoId: videoItem.id,
                                        channelThumbnailUrl:
                                            channelThumbnailsMap![videoItem
                                                        .snippet!.channelId]
                                                    ?.thumbnails
                                                    .high
                                                    .url ??
                                                '',
                                        channelId: videoItem.snippet!.channelId,
                                      );
                                    },
                                    childCount: mostPopularVideos.items.length,
                                  ),
                                );
                              } else {
                                return const SliverToBoxAdapter(
                                  child: VideoLoadingSpinner(),
                                );
                              }
                            },
                          );
                        } else if (popularVideosSnapshot.hasError) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child:
                                  Text('Error: ${popularVideosSnapshot.error}'),
                            ),
                          );
                        }
                        return const SliverToBoxAdapter(
                          child: VideoLoadingSpinner(),
                        );
                      }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
