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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project List'),
        actions: [
          IconButton(
            onPressed: () {
              _openConfirmDialog(
                context,
                null,
                'Logout',
                'Are you sure?',
                'Logged out',
              );
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: _buildBody(provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.projectForm);
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _buildBody(ProjectProvider provider) {
    if (provider.isLoading) {
      return const LoadingState(text: 'Projects');
    }

    if (provider.error != null) {
      return ErrorState(message: provider.error ?? 'Error!');
    }

    if (provider.projects.isEmpty) {
      return const EmptyState(message: 'No projects found');
    }

    return RefreshIndicator(
      onRefresh: () async {
        await provider.fetchProjects();
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 100,
        ),
        itemCount: provider.projects.length,
        itemBuilder: (context, index) {
          final project = provider.projects[index];

          return ProjectCard(
            title: project.title,
            description: project.description,
            createdBy: project.createdBy,

            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.taskList,
                arguments: project.id,
              );
            },

            onEdit: () {
              Navigator.pushNamed(
                context,
                AppRoutes.projectForm,
                arguments: project,
              );
            },

            onDelete: () => _openConfirmDialog(
              context,
              project.id,
              'Delete Project',
              'All tasks inside will be lost.',
              'Project deleted',
            ),
          );
        },
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              if (projectId != null) {
                await context.read<ProjectProvider>().deleteProject(projectId);

                if (!context.mounted) return;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              } else {
                await context.read<AuthProvider>().logout();

                if (!context.mounted) return;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));

                Navigator.pushReplacementNamed(context, AppRoutes.auth);
              }
            },
            child: Text(projectId != null ? 'Delete' : 'Logout'),
          ),
        ],
      ),
    );
  }
}
