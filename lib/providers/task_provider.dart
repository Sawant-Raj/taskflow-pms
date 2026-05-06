import 'package:flutter/cupertino.dart';
import 'package:taskflow_pms/models/enums/task_status.dart';
import 'package:taskflow_pms/models/task_model.dart';
import 'package:taskflow_pms/services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _service = TaskService();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchTasks(String projectId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _tasks = await _service.fetchTasks(projectId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    try {
      final newTask = await _service.createTask(task);

      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    try {
      final index = _tasks.indexWhere((task) => taskId == task.id);
      if (index == -1) return;

      final updatedTask = TaskModel(
        id: _tasks[index].id,
        projectId: _tasks[index].projectId,
        title: _tasks[index].title,
        description: _tasks[index].description,
        status: status,
        dueDate: _tasks[index].dueDate,
      );

      await _service.updateTask(updatedTask);

      _tasks[index] = updatedTask;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _service.deleteTask(taskId);

      _tasks.removeWhere((task) => taskId == task.id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
