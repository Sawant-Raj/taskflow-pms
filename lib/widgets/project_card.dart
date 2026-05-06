import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;
  final Widget trailing;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: trailing,
    );
  }
}
