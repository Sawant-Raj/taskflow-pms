import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_pms/providers/task_provider.dart';
import 'package:taskflow_pms/routes/app_routes.dart';
import 'package:taskflow_pms/widgets/task_card.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  String? projectId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (projectId == null) {
      projectId = ModalRoute.of(context)!.settings.arguments as String;

      Future.microtask(() {
        context.read<TaskProvider>().fetchTasks(projectId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: _buildBody(provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.addEditTask,
            arguments: projectId,
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _buildBody(TaskProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text('Error: ${provider.error}'));
    }

    if (provider.tasks.isEmpty) {
      return const Center(child: Text('No tasks found'));
    }

    return ListView.builder(
      itemCount: provider.tasks.length,
      itemBuilder: (context, index) {
        final task = provider.tasks[index];

        return TaskCard(task: task);
      },
    );
  }
}
