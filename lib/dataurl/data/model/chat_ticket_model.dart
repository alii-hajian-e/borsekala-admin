class TicketChatResponse {
  final TicketChat ticketChat;
  final List<ResponseTicket> responses;

  TicketChatResponse({
    required this.ticketChat,
    required this.responses,
  });

  factory TicketChatResponse.fromJson(Map<String, dynamic> json) {
    return TicketChatResponse(
      ticketChat: TicketChat.fromJson(json['ticket']),
      responses: (json['responses'] as List)
          .map((e) => ResponseTicket.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket': ticketChat.toJson(),
      'responses': responses.map((e) => e.toJson()).toList(),
    };
  }
}

class TicketChat {
  final int id;
  final String title;
  final String description;
  final int category;
  final String createdAt;
  final bool isResolved;
  final String? images;

  TicketChat({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.isResolved,
    this.images,
  });

  factory TicketChat.fromJson(Map<String, dynamic> json) {
    return TicketChat(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      createdAt: json['created_at'],
      isResolved: json['is_resolved'],
      images: json['images'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'created_at': createdAt,
      'is_resolved': isResolved,
      'images': images,
    };
  }
}

class ResponseTicket {
  final int id;
  final int ticket;
  final String responseText;
  final String? responseImages;
  final String createdAt;
  final int state;
  final int sender;

  ResponseTicket({
    required this.id,
    required this.ticket,
    required this.responseText,
    this.responseImages,
    required this.createdAt,
    required this.state,
    required this.sender,
  });

  factory ResponseTicket.fromJson(Map<String, dynamic> json) {
    return ResponseTicket(
      id: json['id'],
      ticket: json['ticket'],
      responseText: json['response_text'],
      responseImages: json['response_images'],
      createdAt: json['created_at'],
      state: json['state'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ticket': ticket,
      'response_text': responseText,
      'response_images': responseImages,
      'created_at': createdAt,
      'state': state,
      'sender': sender,
    };
  }
}
