// ignore_for_file: file_names

class Group {
  final int id;
  final String persianName;
  final String description;
  final int parentId;

  Group({
    required this.id,
    required this.persianName,
    required this.description,
    required this.parentId,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      persianName: json['persianName'],
      description: json['description'],
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'persianName': persianName,
      'description': description,
      'parentId': {'value': parentId},
    };
  }
}