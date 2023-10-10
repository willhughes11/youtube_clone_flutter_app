import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/api/videos.dart';
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
  late Future<PopularVideos>? futurePopularVideos;
  late String baseUrl;
  String? nextPageToken;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:8080';
    } else {
      baseUrl = 'http://192.168.1.250:8080';
    }

    _scrollController.addListener(_reloadDataScrollListener);
    _scrollController.addListener(_loadMoreDataScrollListener);

    futureVideoCategories = fetchVideoCategories(baseUrl);
    futurePopularVideos = fetchPopularVideos(baseUrl);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void updateSelectedVideoCategory(String videoCatgoryId) {
    setState(() {
      selectedVideCategoryId = videoCatgoryId;
    });
  }

  void _reloadDataScrollListener() {
    if (_scrollController.position.pixels == 0) {
      // User scrolled to the top, trigger refresh
      _handleRefresh();
    }
  }

  void _loadMoreDataScrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        loadDataOnScroll(baseUrl, selectedVideCategoryId, nextPageToken);
      }
    }
  }

  Future<void> loadDataOnScroll(
      String baseUrl, String categoryId, String? pageToken) async {
    final newPopularVideos =
        await fetchPopularVideos(baseUrl, categoryId, pageToken);
    final popularVideos = await futurePopularVideos;
    setState(() {
      popularVideos!.items.addAll(newPopularVideos.items);
      futurePopularVideos = Future.value(popularVideos);
      nextPageToken = newPopularVideos.nextPageToken; // Update nextPageToken
      isLoading = false; // Set isLoading to false
    });
  }

  Future<void> fetchAndSetPopularVideos(String baseUrl, String categoryId,
      [String? pageToken]) async {
    try {
      final newPopularVideos =
          await fetchPopularVideos(baseUrl, categoryId, pageToken);
      setState(() {
        futurePopularVideos = Future.value(newPopularVideos);
        nextPageToken = newPopularVideos.nextPageToken;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _handleRefresh() async {
    // Perform your data fetching or reloading logic here
    final newPopularVideos =
        await fetchPopularVideos(baseUrl, selectedVideCategoryId);
    setState(() {
      futurePopularVideos = Future.value(newPopularVideos);
      nextPageToken = newPopularVideos.nextPageToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: customBlack.shade800,
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: Colors.grey,
          backgroundColor: Colors.transparent,
          child: Center(
            child: FutureBuilder<VideoCategories>(
              future: futureVideoCategories,
              builder: (context, categorySnapshot) {
                var categoryItems = categorySnapshot.data?.items ?? [];
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: customBlack.shade800,
                      floating: true,
                      flexibleSpace: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: VideoFilterBar(
                            selectedFilterId: selectedVideCategoryId,
                            filterItems: categoryItems,
                            baseUrl: baseUrl,
                            updateSelectedFilterCategory:
                                updateSelectedVideoCategory,
                            fetchAndSetPopularVideos: fetchAndSetPopularVideos),
                      ),
                    ),
                    FutureBuilder<PopularVideos>(
                        future: futurePopularVideos,
                        builder: (context, popularVideosSnapshot) {
                          if (popularVideosSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SliverToBoxAdapter(
                              child: VideoLoadingSpinner(
                                optionalColor: Colors.red,
                              ),
                            );
                          } else if (popularVideosSnapshot.hasData) {
                            final mostPopularVideos =
                                popularVideosSnapshot.data;

                            if (mostPopularVideos == null ||
                                mostPopularVideos.items.isEmpty) {
                              return const Text('No popular videos available');
                            }

                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  final videoItem =
                                      mostPopularVideos.items[index];
                                  return TappableCard(
                                    videoThumbnailUrl: videoItem
                                            .snippet!.thumbnails?.maxres?.url ??
                                        videoItem.snippet!.thumbnails!.high.url,
                                    title: videoItem.snippet!.title,
                                    channelTitle:
                                        videoItem.snippet!.channelTitle!,
                                    viewCount: videoItem.statistics!.viewCount,
                                    publishedAt:
                                        videoItem.snippet!.publishedAt!,
                                    videoId: videoItem.id,
                                    channelThumbnailUrl: videoItem
                                        .snippet!.channelThumbnails?.high.url,
                                    channelId: videoItem.snippet!.channelId,
                                  );
                                },
                                childCount: mostPopularVideos.items.length,
                              ),
                            );
                          } else if (popularVideosSnapshot.hasError) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: Text(
                                    'Error: ${popularVideosSnapshot.error}'),
                              ),
                            );
                          } else {
                            return const SliverToBoxAdapter(
                              child: VideoLoadingSpinner(
                                optionalColor: Colors.red,
                              ),
                            );
                          }
                        }),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
