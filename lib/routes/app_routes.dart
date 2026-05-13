import 'package:taskflow_pms/screens/auth/auth_screen.dart';
import 'package:taskflow_pms/screens/project/project_list_screen.dart';
import 'package:taskflow_pms/screens/task/task_form_screen.dart';
import 'package:taskflow_pms/screens/task/task_list_screen.dart';
import '../screens/project/project_form_screen.dart';

class AppRoutes {
  static const auth = '/auth';
  static const projectList = '/projects';
  static const projectForm = '/project-form';
  static const taskList = '/tasks';
  static const taskForm = '/task-form';

  static final routes = {
    auth: (context) => const AuthScreen(),
    projectList: (context) => const ProjectListScreen(),
    projectForm: (context) => const ProjectFormScreen(),
    taskList: (context) => const TaskListScreen(),
    taskForm: (context) => const TaskFormScreen(),
  };
}
