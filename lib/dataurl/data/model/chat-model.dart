// ignore_for_file: file_names

class Message {
  int id;
  bool isAdminMessage;
  int state;
  String content;
  DateTime createdAt;
  DateTime updatedAt;
  int user;

  Message({
    required this.id,
    required this.isAdminMessage,
    required this.state,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      isAdminMessage: json['is_admin_message'],
      state: json['state'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: json['user'],
    );
  }
}