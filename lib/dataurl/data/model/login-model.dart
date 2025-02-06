// ignore_for_file: file_names

class VerifyModel {
  VerifyModel({ this.access,this.refresh ,this.isAdmin});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
    isAdmin = json['is_admin'];

  }

  String? access;
  String? refresh;
  bool? isAdmin;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    data['is_admin'] = isAdmin;
    return data;
  }
}