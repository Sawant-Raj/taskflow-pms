import 'package:taskflow_pms/models/task_model.dart';
import 'package:taskflow_pms/services/api_service.dart';

class TaskService {
  final ApiService _api = ApiService();

  Future<List<TaskModel>> fetchTasks(String projectId) async {
    final data = await _api.get('tasks');

    return List<TaskModel>.from(
      data
          .where((t) => t['projectId'] == projectId)
          .map((json) => TaskModel.fromJson(json)),
    );
  }

  Future<TaskModel> createTask(TaskModel task) async {
    final data = await _api.post('tasks', task.toJson());
    return TaskModel.fromJson(data);
  }

  Future<TaskModel> updateTask(TaskModel task) async {
    final data = await _api.put('tasks/${task.id}', task.toJson());
    return TaskModel.fromJson(data);
  }

  Future<void> deleteTask(String id) async {
    await _api.delete('tasks/$id');
  }
}
