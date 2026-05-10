import 'package:taskflow_pms/screens/auth/login_screen.dart';
import 'package:taskflow_pms/screens/project/add_project_screen.dart';
import 'package:taskflow_pms/screens/project/project_list_screen.dart';
import 'package:taskflow_pms/screens/task/add_edit_task_screen.dart';
import 'package:taskflow_pms/screens/task/task_list_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const projectList = 'project-list';
  static const addProject = '/add-project';
  static const taskList = '/task-list';
  static const addEditTask = '/add-edit-task';

  static final routes = {
    login: (context) => const LoginScreen(),
    projectList: (context) => const ProjectListScreen(),
    addProject: (context) => const AddProjectScreen(),
    taskList: (context) => const TaskListScreen(),
    addEditTask: (context) => const AddEditTaskScreen(),
  };
}
