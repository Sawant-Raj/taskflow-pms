import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String statusName;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.statusName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Text(statusName),
    );
  }
}
