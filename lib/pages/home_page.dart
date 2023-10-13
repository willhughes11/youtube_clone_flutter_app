import 'package:flutter/material.dart';

import 'package:live_sync_flutter_app/api/videos.dart';
import 'package:live_sync_flutter_app/models/video_categories.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/models/popular_videos.dart';
import 'package:live_sync_flutter_app/widgets/video_category_app_bar.dart';
import 'package:live_sync_flutter_app/widgets/video_sliver_list_view.dart';
import 'package:live_sync_flutter_app/widgets/video_loading_spinner.dart';

import 'dart:io';

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
  bool _isLoadingNewVideos = false;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  late PopularVideos data;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      baseUrl = 'http://10.0.2.2:8080';
    } else {
      baseUrl = 'http://192.168.1.250:8080';
    }

    _scrollController.addListener(_reloadDataScrollListener);
    _scrollController.addListener(_onScroll);

    fetchData();
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

  Future<void> fetchData() async {
    futureVideoCategories = fetchVideoCategories(baseUrl);
    futurePopularVideos = fetchPopularVideos(baseUrl);
    data = await futurePopularVideos;
  }

  Future<void> fetchAndSetPopularVideos(String baseUrl, String categoryId,
      [String? pageToken]) async {
    try {
      setState(() {
        _isLoadingNewVideos = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      final newPopularVideos =
          await fetchPopularVideos(baseUrl, categoryId, pageToken);
      setState(() {
        data.updateFromApiData(newPopularVideos, true);
        futurePopularVideos = Future.value(data);
        _isLoadingNewVideos = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoadingNewVideos = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Perform your data fetching or reloading logic here
    final newPopularVideos =
        await fetchPopularVideos(baseUrl, selectedVideCategoryId);
    setState(() {
      data.updateFromApiData(newPopularVideos, true);
      futurePopularVideos = Future.value(data);
    });
  }

  void _reloadDataScrollListener() {
    if (_scrollController.position.pixels == 0) {
      _handleRefresh();
    }
  }

  void _onScroll() {
    if (!_isLoading &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent) {
      // User has scrolled to the end of the list, load more data.
      _loadMoreData();
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Fetch more data and append it to the 'data' list.
    PopularVideos newData = await fetchPopularVideos(
        baseUrl, selectedVideCategoryId, data.nextPageToken);
    data.updateFromApiData(newData);

    var fuPopVids = await futurePopularVideos;
    debugPrint("FuPopVids: ${fuPopVids.items.length}");
    debugPrint("Data: ${data.items.length}");

    setState(() {
      _isLoading = false;
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
              child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              FutureBuilder<VideoCategories>(
                future: futureVideoCategories,
                builder: (context, categorySnapshot) {
                  var categoryItems = categorySnapshot.data?.items ?? [];
                  return VideoCategoryAppBar(
                    baseUrl: baseUrl,
                    selectedFilterId: selectedVideCategoryId,
                    categoryItems: categoryItems,
                    updateSelectedFilterCategory: updateSelectedVideoCategory,
                    fetchAndSetPopularVideos: fetchAndSetPopularVideos,
                  );
                },
              ),
              FutureBuilder<PopularVideos>(
                future: futurePopularVideos,
                builder: (context, popularVideosSnapshot) {
                  if (popularVideosSnapshot.connectionState ==
                          ConnectionState.waiting ||
                      _isLoadingNewVideos == true) {
                    return const SliverToBoxAdapter(
                      child: VideoLoadingSpinner(
                        optionalColor: Colors.red,
                      ),
                    );
                  } else if (popularVideosSnapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Text('Error: ${popularVideosSnapshot.error}'),
                    );
                  } else {
                    return VideoSliverListView(
                      data: popularVideosSnapshot.data,
                    );
                  }
                },
              ),
              SliverToBoxAdapter(
                child: _isLoading
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 64.0),
                          child: VideoLoadingSpinner(
                            optionalColor: Colors.red,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
