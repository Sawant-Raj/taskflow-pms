import 'package:taskflow_pms/models/project_model.dart';
import 'package:taskflow_pms/services/api_service.dart';

class ProjectService {
  final ApiService _api = ApiService();

  Future<List<ProjectModel>> fetchProjects() async {
    final data = await _api.get('projects');
    return List<ProjectModel>.from(
      data.map((json) => ProjectModel.fromJson(json)),
    );
  }

  Future<ProjectModel> createProject(ProjectModel projectModel) async {
    final data = await _api.post('projects', projectModel.toJson());
    return ProjectModel.fromJson(data);
  }

  Future<ProjectModel> updateProject(ProjectModel projectModel) async {
    final data = await _api.put(
      'projects/${projectModel.id}',
      projectModel.toJson(),
    );
    return ProjectModel.fromJson(data);
  }

  Future<void> deleteProject(String id) async {
    await _api.delete('projects/$id');
  }
}
