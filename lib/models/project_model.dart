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
      'id': id.trim(),
      'title': title.trim(),
      'description': description.trim(),
      'createdBy': createdBy.trim(),
    };
  }
}
