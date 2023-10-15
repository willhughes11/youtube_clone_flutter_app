// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/api/video_categories.dart';

import 'package:youtube_clone_flutter_app/api/videos.dart';
import 'package:youtube_clone_flutter_app/models/video_categories.dart';
import 'package:youtube_clone_flutter_app/pages/root_page.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/models/videos.dart';
import 'package:youtube_clone_flutter_app/widgets/features/home/video_category_app_bar.dart';
import 'package:youtube_clone_flutter_app/widgets/features/home/video_sliver_list_view.dart';
import 'package:youtube_clone_flutter_app/widgets/global/custom_loading_spinner.dart';

import 'dart:io';

class HomePage extends StatefulWidget {
  final MyBuilder builder;
  const HomePage({super.key, required this.builder});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedVideCategoryId = "0";
  late Future<VideoCategories> futureVideoCategories;
  late Future<Videos> futurePopularVideos;
  late String baseUrl;
  bool _isLoadingNewVideos = false;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();
  late Videos data;

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
      // await Future.delayed(const Duration(seconds: 1));
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
    // await Future.delayed(const Duration(seconds: 1));
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

    Videos newData = await fetchPopularVideos(
        baseUrl, selectedVideCategoryId, data.nextPageToken);
    data.updateFromApiData(newData);

    setState(() {
      _isLoading = false;
    });
  }

  void scrollToTop() {
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        1,
        duration:
            const Duration(milliseconds: 500), // Adjust the duration as needed
        curve: Curves.easeInOut, // Choose an easing curve
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, scrollToTop);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: customBlack.shade900,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.all(12.0),
                child: Image.asset('assets/images/youtube-logo-white-text.png', width: 100,),
              )
              
            ],
          ),
          leadingWidth: 200,
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle),
            )
          ],
        ),
        backgroundColor: customBlack.shade900,
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
              FutureBuilder<Videos>(
                future: futurePopularVideos,
                builder: (context, popularVideosSnapshot) {
                  if (popularVideosSnapshot.connectionState ==
                          ConnectionState.waiting ||
                      _isLoadingNewVideos == true) {
                    return const SliverToBoxAdapter(
                      child: CustomLoadingSpinner(
                        optionalColor: Colors.grey,
                      ),
                    );
                  } else if (popularVideosSnapshot.hasError) {
                    return SliverToBoxAdapter(
                      child: Text('Error: ${popularVideosSnapshot.error}'),
                    );
                  } else {
                    return VideoSliverListView(
                      baseUrl: baseUrl,
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
                          child: CustomLoadingSpinner(
                            optionalColor: Colors.grey,
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