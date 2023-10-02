import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/custom/material_colors.dart';
import 'package:live_sync_flutter_app/home_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;
  List<Widget> pages = const [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: pages[currentPage],
      body: const HomePage(),
      appBar: AppBar(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: (){},
              icon: const Icon(Icons.slideshow),
            ),
            const Text('LiveSync'),
            const SizedBox(width: 2.0),
          ],
        ),
        leadingWidth: 150,
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
        backgroundColor: customBlack,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: currentPage,
        onTap: (int index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
    );
  }
}
