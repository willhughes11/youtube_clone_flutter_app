import 'package:flutter/material.dart';
import 'package:youtube_clone_flutter_app/pages/library_page.dart';
import 'package:youtube_clone_flutter_app/pages/shorts_page.dart';
import 'package:youtube_clone_flutter_app/pages/subscriptions_page.dart';
import 'package:youtube_clone_flutter_app/utils/colors.dart';
import 'package:youtube_clone_flutter_app/pages/home_page.dart';

typedef MyBuilder = void Function(
    BuildContext context, void Function() methodA);

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget?> pages = [];
  late void Function() parentScrollToTop;

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(
        builder: (BuildContext context, void Function() childScrollToTop) {
          parentScrollToTop = childScrollToTop;
        },
      ),
      const ShortsPage(),
      null,
      const SubscriptionsPage(),
      const LibraryPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              activeIcon: Icon(Icons.play_circle_filled),
              label: 'Shorts'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
                size: 40,
              ),
              activeIcon: Icon(
                Icons.add_circle,
                size: 40,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions_outlined),
              activeIcon: Icon(Icons.subscriptions),
              label: 'Subscriptions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined),
              activeIcon: Icon(Icons.video_library),
              label: 'Library'),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: customBlack.shade900,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: currentPage,
        onTap: (int index) {
          setState(() {
            if (index != 2 && index != currentPage) {
              currentPage = index;
            } else {
              parentScrollToTop();
            }
          });
        },
      ),
    );
  }
}
