// ignore_for_file: file_names

class SubGroup {
  late String persianName;
  final int parentId;
  late String description;
  late int id;

  SubGroup({
    required this.persianName,
    required this.parentId,
    required this.description,
    required this.id,
  });

  factory SubGroup.fromJson(Map<String, dynamic> json) {
    return SubGroup(
      persianName: json['persianName'],
      parentId: json['parentId'],
      description: json['description'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persianName': persianName,
      'parentId': {'value': parentId},
      'description': description,
      'id': id,
    };
  }
}

class Company {
  late String persianName;
  late String description;
  late String symbol;
  late int id;

  Company({
    required this.persianName,
    required this.description,
    required this.symbol,
    required this.id,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      persianName: json['persianName'],
      description: json['description'],
      symbol: json['symbol'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persianName': persianName,
      'description': description,
      'id': id,
    };
  }
}