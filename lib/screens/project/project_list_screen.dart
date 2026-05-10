import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_pms/providers/auth_provider.dart';
import 'package:taskflow_pms/providers/project_provider.dart';
import 'package:taskflow_pms/routes/app_routes.dart';
import 'package:taskflow_pms/widgets/empty_state.dart';
import 'package:taskflow_pms/widgets/error_state.dart';
import 'package:taskflow_pms/widgets/loading_state.dart';
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
      return LoadingState();
    }

    if (provider.error != null) {
      return ErrorState(message: provider.error ?? 'Error!');
    }

    if (provider.projects.isEmpty) {
      return EmptyState(message: 'No projects found');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Project List'),
        actions: [
          IconButton(
            onPressed: () async {
              _openConfirmDialog(
                context,
                null,
                'Logout',
                'Are you sure?',
                'Logged out',
              );

              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            icon: Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await provider.fetchProjects();
        },
        child: ListView.builder(
          itemCount: provider.projects.length,
          itemBuilder: (context, index) {
            final project = provider.projects[index];
            return ProjectCard(
              title: project.title,
              description: project.description,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.taskList,
                  arguments: project.id,
                );
              },
              trailing: IconButton(
                onPressed: () => _openConfirmDialog(
                  context,
                  project.id,
                  'Delete Project',
                  'All tasks inside will be lost.',
                  'Project deleted',
                ),
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addProject);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  void _openConfirmDialog(
    BuildContext context,
    String? projectId,
    String title,
    String content,
    String message,
  ) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              projectId != null
                  ? await context.read<ProjectProvider>().deleteProject(
                      projectId,
                    )
                  : await context.read<AuthProvider>().logout();

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            child: Text(projectId != null ? 'Delete' : 'Logout'),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {}
}
