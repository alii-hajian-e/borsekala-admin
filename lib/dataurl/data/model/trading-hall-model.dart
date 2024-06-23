

// ignore_for_file: file_names

class TradingHall {
  final String persianName;
  final String name;
  final int id;

  TradingHall({
    required this.persianName,
    required this.name,
    required this.id,
  });

  factory TradingHall.fromJson(Map<String, dynamic> json) {
    return TradingHall(
      persianName: json['parent_name'],
      name: json['name'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'parent_name': persianName,
      'name': name,
      'id': id,
    };
  }
}