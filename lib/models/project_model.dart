class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String createdBy;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdBy,
  });

  ProjectModel copyWith({
    String? id,
    String? title,
    String? description,
    String? createdBy,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdBy: json['createdBy'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title.trim(),
      'description': description.trim(),
      'createdBy': createdBy.trim(),
    };
  }
}
