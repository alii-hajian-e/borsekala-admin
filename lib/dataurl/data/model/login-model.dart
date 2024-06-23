// ignore_for_file: file_names

class VerifyModel {
  VerifyModel({ this.access,this.refresh});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    refresh = json['refresh'];
  }

  String? access;
  String? refresh;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    data['refresh'] = refresh;
    return data;
  }
}