// ignore_for_file: file_names

class ModelUser {
  final int id;
  final String name;
  // final String family;
  final String phone;
  final String createdAt;
  final String? company;
  final bool isActive;

  ModelUser({
    required this.id,
    required this.name,
    // required this.family,
    required this.phone,
    required this.createdAt,
    required this.company,
    required this.isActive,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json['id'],
      name: json['name'],
      // family: json['family'],
      phone: json['phone'],
      createdAt: json['created_at'],
      company: json['company'],
      isActive: json['is_active'],
    );
  }
}