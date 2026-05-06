import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskflow_pms/models/enums/task_status.dart';
import 'package:taskflow_pms/models/task_model.dart';
import 'package:taskflow_pms/providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  const AddEditTaskScreen({super.key});

  @override
  State<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  TaskStatus _selectedStatus = TaskStatus.todo;
  DateTime? _dueDate;

  bool _isSubmitting = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().subtract(const Duration(days: 1)),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _submit(String projectId) async {
    final title = _titleController.text.trim();
    final description = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Title is required')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final task = TaskModel(
        id: '',
        projectId: projectId,
        title: title,
        description: description,
        status: _selectedStatus,
        assignedTo: 'user123',
        dueDate: _dueDate,
      );

      await context.read<TaskProvider>().addTask(task);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Task added')));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    if (mounted) {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<TaskStatus>(
              value: _selectedStatus,
              items: TaskStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Text(
                    _dueDate == null
                        ? 'No due date selected'
                        : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Select Date'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : () => _submit(projectId),
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : Text('Create Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
