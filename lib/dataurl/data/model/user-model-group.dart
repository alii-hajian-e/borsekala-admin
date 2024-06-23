// ignore_for_file: file_names

class Model {
  int id;
  DateTime createdAt;
  User user;
  Room room;

  Model({
    required this.id,
    required this.createdAt,
    required this.user,
    required this.room,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      room: Room.fromJson(json['room']),
    );
  }
}

class User {
  int id;
  String name;
  String family;
  String phone;
  DateTime createdAt;

  User({
    required this.id,
    required this.name,
    required this.family,
    required this.phone,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      family: json['family'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class Room {
  String name;
  int id;
  int mainGroup;
  int group;
  String subGroup;
  int hallId;
  DateTime createdAt;

  Room({
    required this.name,
    required this.id,
    required this.mainGroup,
    required this.group,
    required this.subGroup,
    required this.hallId,
    required this.createdAt,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      id: json['id'],
      mainGroup: json['main_group'],
      group: json['group'],
      subGroup: json['sub_group'],
      hallId: json['hall_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}