import 'package:taskflow_pms/models/task_model.dart';
import 'package:taskflow_pms/services/api_service.dart';

class TaskService {
  ApiService _api = ApiService();

  Future<List<TaskModel>> fetchTasks(String projectId) async {
    final data = await _api.get('tasks');

    return List<TaskModel>.from(
      data
          .where((t) => t['projectId'] == projectId)
          .map((json) => TaskModel.fromJson(json)),
    );
  }

  Future<TaskModel> createTask(TaskModel taskModel) async {
    final data = await _api.post('tasks', taskModel.toJson());
    return TaskModel.fromJson(data);
  }

  Future<TaskModel> updateTask(TaskModel taskModel) async {
    final data = await _api.put('tasks/${taskModel.id}', taskModel.toJson());
    return TaskModel.fromJson(data);
  }

  Future<void> deleteTask(String id) async {
    await _api.delete('tasks/$id');
  }
}
