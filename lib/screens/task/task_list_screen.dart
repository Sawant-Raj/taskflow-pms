import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_pms/providers/task_provider.dart';
import 'package:taskflow_pms/routes/app_routes.dart';
import 'package:taskflow_pms/widgets/empty_state.dart';
import 'package:taskflow_pms/widgets/loading_state.dart';
import 'package:taskflow_pms/widgets/task_card.dart';

import '../../widgets/error_state.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String? _projectId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_projectId == null) {
      _projectId = ModalRoute.of(context)!.settings.arguments as String;

      Future.microtask(() {
        context.read<TaskProvider>().fetchTasks(_projectId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: _buildBody(provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.taskForm,
            arguments: _projectId,
          );
        },
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  Widget _buildBody(TaskProvider provider) {
    if (provider.isLoading) {
      return LoadingState(text: 'Tasks');
    }

    if (provider.error != null) {
      return ErrorState(message: provider.error ?? 'Error!');
    }

    if (provider.tasks.isEmpty) {
      return EmptyState(message: 'No tasks found');
    }

    return RefreshIndicator(
      onRefresh: () async {
        await provider.fetchTasks(_projectId!);
      },
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 100,
        ),
        itemCount: provider.tasks.length,
        itemBuilder: (context, index) {
          final task = provider.tasks[index];

          return TaskCard(task: task);
        },
      ),
    );
  }
}
