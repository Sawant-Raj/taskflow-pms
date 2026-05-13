import 'package:flutter/material.dart';
import 'package:taskflow_pms/models/task_model.dart';
import 'package:taskflow_pms/routes/app_routes.dart';

import '../core/utils/task_utils.dart';
import '../models/enums/task_status.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isUpdatingStatus = false;

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Ink(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            GestureDetector(
                              onTap: () async {
                                if (!_isUpdatingStatus) {
                                  await _changeStatus(context, task);
                                }
                              },
                              child: _isUpdatingStatus
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(
                                          task.status,
                                        ).withValues(alpha: 0.14),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Text(
                                        statusLabel(task.status),
                                        style: TextStyle(
                                          color: getStatusColor(task.status),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),

                      PopupMenuButton<String>(
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        onSelected: (value) {
                          if (value == 'edit') {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.taskForm,
                              arguments: task,
                            );
                          } else if (value == 'delete') {
                            _confirmDeleteTask(context, task.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit_outlined, size: 20),
                                SizedBox(width: 10),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  if (task.description.trim().isNotEmpty) ...[
                    const SizedBox(height: 12),

                    Text(
                      task.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                        height: 1.45,
                      ),
                    ),
                  ],

                  if ((task.assignedTo != null &&
                          task.assignedTo!.trim().isNotEmpty) ||
                      task.dueDate != null) ...[
                    const SizedBox(height: 14),

                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        if (task.assignedTo != null &&
                            task.assignedTo!.trim().isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.person_outline_rounded,
                                  size: 15,
                                  color: theme.colorScheme.primary,
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  task.assignedTo!,
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        if (task.dueDate != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:Color(0xFF7C3AED).withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.schedule_rounded,
                                  size: 15,
                                  color: Color(0xFF7C3AED),
                                ),

                                const SizedBox(width: 5),

                                Text(
                                  task.dueDate!.toLocal().toString().split(
                                    ' ',
                                  )[0],
                                  style: TextStyle(
                                    color: Color(0xFF7C3AED),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _changeStatus(BuildContext context, TaskModel task) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: TaskStatus.values.map((status) {
              return ListTile(
                title: Text(statusLabel(status)),
                onTap: () async {
                  Navigator.pop(context);

                  setState(() {
                    _isUpdatingStatus = true;
                  });

                  try {
                    await context.read<TaskProvider>().updateTaskStatus(
                      task.id,
                      status,
                    );

                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Status updated")),
                    );
                  } finally {
                    if (mounted) {
                      setState(() {
                        _isUpdatingStatus = false;
                      });
                    }
                  }
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

                if (!context.mounted) return;

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
