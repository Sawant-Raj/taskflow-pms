import 'package:flutter/cupertino.dart';
import 'package:taskflow_pms/models/project_model.dart';
import 'package:taskflow_pms/services/project_service.dart';

class ProjectProvider with ChangeNotifier {
  final ProjectService _service = ProjectService();

  List<ProjectModel> _projects = [];
  bool _isLoading = false;
  String? _error;

  List<ProjectModel> get projects => _projects;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchProjects() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _projects = await _service.fetchProjects();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProject(ProjectModel projectModel) async {
    try {
      final newProject = await _service.createProject(projectModel);

      _projects.add(newProject);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
