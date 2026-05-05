import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_pms/providers/project_provider.dart';
import 'package:taskflow_pms/routes/app_routes.dart';
import 'package:taskflow_pms/widgets/project_card.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => context.read<ProjectProvider>().fetchProjects());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProjectProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    if (provider.projects.isEmpty) {
      return const Center(child: Text("No projects found"));
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: provider.projects.length,
        itemBuilder: (context, index) {
          final project = provider.projects[index];
          return ProjectCard(
            title: project.title,
            description: project.description,
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.projectDetails,
                arguments: project.id,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addProject);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
