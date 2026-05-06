import 'package:flutter/material.dart';
import 'package:taskflow_pms/models/task_model.dart';

import '../core/utils/task_utils.dart';
import '../models/enums/task_status.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            const SizedBox(height: 4),
            if (task.dueDate != null)
              Text(
                'Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                _changeStatus(context, task);
              },
              child: Chip(
                label: Text(statusToString(task.status)),
                backgroundColor: getStatusColor(task.status),
              ),
            ),
            const SizedBox(width: 8),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _confirmDeleteTask(context, task.id),
            ),
          ],
        ),
      ),
    );
  }

  void _changeStatus(BuildContext context, TaskModel task) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: TaskStatus.values.map((status) {
              return ListTile(
                title: Text(status.name),
                onTap: () async {
                  Navigator.pop(context);

                  await context.read<TaskProvider>().updateTaskStatus(
                    task.id,
                    status,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Status updated")),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _confirmDeleteTask(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Task"),
          content: const Text("Are you sure you want to delete this task?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await context.read<TaskProvider>().deleteTask(taskId);

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Task deleted")));
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
