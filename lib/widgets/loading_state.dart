import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  final String text;
  const LoadingState({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text("Loading $text..."),
        ],
      ),
    );
  }
}
