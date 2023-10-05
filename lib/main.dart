import 'package:flutter/material.dart';
import 'package:live_sync_flutter_app/utils/colors.dart';
import 'package:live_sync_flutter_app/pages/root_page.dart';

void main() {
  runApp(const LiveSyncApp());
}

class LiveSyncApp extends StatelessWidget {
  const LiveSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: customBlack),
      home: const RootPage(),
    );
  }
}