// ignore_for_file: file_names

class Ticket {
  int id;
  String title;
  String description;
  int category;
  String createdAt;
  bool isResolved;
  String? images;

  Ticket({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.isResolved,
    required this.images,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      createdAt: json['created_at'],
      isResolved: json['is_resolved'],
      images: json['images'],
    );
  }
}

class TicketCategory {
  int id;
  String name;
  String description;

  TicketCategory({
    required this.id,
    required this.name,
    required this.description,
  });

  factory TicketCategory.fromJson(Map<String, dynamic> json) {
    return TicketCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}