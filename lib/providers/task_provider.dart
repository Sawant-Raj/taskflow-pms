import 'package:flutter/cupertino.dart';
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

  Future<void> addTask(TaskModel taskModel) async {
    try {
      final newTask = await _service.createTask(taskModel);

      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
