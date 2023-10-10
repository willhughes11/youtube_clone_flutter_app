import 'package:flutter/material.dart';

class VideoLoadingSpinner extends StatelessWidget {
  final Color? optionalColor;
  const VideoLoadingSpinner({super.key, this.optionalColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        child: SizedBox(
          child: Opacity(
            opacity: 0.5,
            child: CircularProgressIndicator(color: optionalColor ?? Colors.grey),
          ),
        ),
      ),
    );
  }
}
