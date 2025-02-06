// ignore_for_file: file_names

class MainGroup {
  final int id;
  final String persianName;
  final dynamic icon;
  final String description;

  MainGroup({
    required this.id,
    required this.persianName,
    required this.icon,
    required this.description,
  });

  factory MainGroup.fromJson(Map<String, dynamic> json) {
    return MainGroup(
      id: json['id'],
      persianName: json['persianName'],
      icon: json['icon'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'persianName': persianName,
      'icon': icon,
      'description': description,
    };
  }
}