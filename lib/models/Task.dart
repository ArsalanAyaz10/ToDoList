class Task {
  final String id;
  final String description;

  Task({required this.id, required this.description});

  Map<String, dynamic> toJson() => {
    'id': id,
    'description': description,
  };

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      description: json['description'] as String,
    );
  }
}
