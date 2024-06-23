// ignore_for_file: file_names

class ModelUser {
  final int id;
  final String name;
  final String family;
  final String phone;
  final String createdAt;

  ModelUser({
    required this.id,
    required this.name,
    required this.family,
    required this.phone,
    required this.createdAt,
  });

  factory ModelUser.fromJson(Map<String, dynamic> json) {
    return ModelUser(
      id: json['id'],
      name: json['name'],
      family: json['family'],
      phone: json['phone'],
      createdAt: json['created_at'],
    );
  }
}