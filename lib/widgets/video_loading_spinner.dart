import 'package:flutter/material.dart';

class VideoLoadingSpinner extends StatelessWidget {
  const VideoLoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: const SizedBox(
          child: Opacity(
            opacity: 0.5,
            child: CircularProgressIndicator(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
