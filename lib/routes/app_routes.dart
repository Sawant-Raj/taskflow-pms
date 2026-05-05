import 'package:taskflow_pms/screens/auth/login_screen.dart';
import 'package:taskflow_pms/screens/dashboard/dashboard_screen.dart';
import 'package:taskflow_pms/screens/project/add_project_screen.dart';
import 'package:taskflow_pms/screens/project/project_detail_screen.dart';
import 'package:taskflow_pms/screens/task/add_edit_task_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const projectDetails = '/project-details';
  static const addProject = '/add-project';
  static const addEditTask = '/add-edit-task';

  static final routes = {
    login: (context) => const LoginScreen(),
    dashboard: (context) => const DashboardScreen(),
    projectDetails: (context) => const ProjectDetailScreen(),
    addProject: (context) => const AddProjectScreen(),
    addEditTask: (context) => const AddEditTaskScreen(),
  };
}
