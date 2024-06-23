class GroupList {
  GroupList({
    this.id,
    this.userCount,
    this.name,
    this.mainGroup,
    this.group,
    this.subGroup,
    this.hallId,
    this.createdAt,
    this.manufacturer,
  });

  GroupList.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    userCount = json['user_count'] ?? 0;
    name = json['name'] ?? '';
    mainGroup = json['main_group'] ?? 0;
    group = json['group'] ?? 0;
    subGroup = json['sub_group'] ?? '';
    hallId = json['hall_id'] ?? 0;
    createdAt = json['created_at'] ?? '';
    manufacturer = json['manufacturer'] ?? '';

  }

  int? id;
  int? userCount;
  String? name;
  int? mainGroup;
  int? group;
  String? subGroup;
  int? hallId;
  String? createdAt;
  String? manufacturer;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_count'] = userCount;
    data['name'] = name;
    data['main_group'] = mainGroup;
    data['group'] = group;
    data['sub_group'] = subGroup;
    data['hall_id'] = hallId;
    data['created_at'] = createdAt;
    data['manufacturer'] = manufacturer;

    return data;
  }
}

