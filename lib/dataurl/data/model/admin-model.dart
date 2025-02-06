// ignore_for_file: file_names

class AdminModel {
  final int? id;
  final String? email;
  final String? family;
  final String? name;
  final bool isActive;

  AdminModel({
    required this.id,
    required this.email,
    required this.family,
    required this.name,
    required this.isActive,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) {
    return AdminModel(
      id: json['id'],
      email: json['email'],
      family: json['family'],
      name: json['name'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'family': family,
      'name': name,
      'is_active': isActive,
    };
  }
}