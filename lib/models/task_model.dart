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

  TaskModel copyWith({
    String? id,
    String? projectId,
    String? title,
    String? description,
    TaskStatus? status,
    String? assignedTo,
    DateTime? dueDate,
  }) {
    return TaskModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      assignedTo: assignedTo ?? this.assignedTo,
      dueDate: dueDate ?? this.dueDate,
    );
  }

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
      'projectId': projectId.trim(),
      'title': title.trim(),
      'description': description.trim(),
      'status': statusToString(status),
      'assignedTo': assignedTo?.trim(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }
}
