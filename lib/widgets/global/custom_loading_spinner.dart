import 'package:flutter/material.dart';

class CustomLoadingSpinner extends StatelessWidget {
  final Color? optionalColor;
  const CustomLoadingSpinner({super.key, this.optionalColor});

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
