import 'enums/task_status.dart';

class TaskModel {
  final String id;
  final String projectId;
  final String title;
  final String description;
  final TaskStatus status;
  final String? assignedTo;
  final DateTime? dueDate;

  const TaskModel({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.status,
    this.assignedTo,
    required this.dueDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      projectId: json['projectId'],
      title: json['title'],
      description: json['description'],
      status: statusFromString(json['status']),
      assignedTo: json['assignedTo'],
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectId': projectId,
      'title': title,
      'description': description,
      'status': statusToString(status),
      'assignedTo': assignedTo,
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
