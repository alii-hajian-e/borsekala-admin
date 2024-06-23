import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class MyPreferences {
  static final _prefs = GetStorage();

  static void setToken(String token) {
    _prefs.write("token", token.toString());
  }
  static String getToken() {
    return _prefs.read<String>("token") ?? "";
  }

  static void setGroup(List<dynamic> group) {
    Map<String, dynamic> map = {};
    for (var item in group) {
      var id = item['id'].toString(); // تبدیل کلید به رشته
      map[id] = item;
    }
    String jsonMap = jsonEncode(map);
    _prefs.write('group', jsonMap);
  }
  static Map<String, dynamic> getGroup() {
    final jsonData = _prefs.read('group');
    return json.decode(jsonData);

  }
  static void setMainGroup(List<dynamic> mainGroup) {
    Map<String, dynamic> map = {};
    for (var item in mainGroup) {
      var id = item['id'].toString(); // تبدیل کلید به رشته
      map[id] = item;
    }

    String jsonMap = jsonEncode(map);
    _prefs.write('mainGroup', jsonMap);
  }
  static Map<String, dynamic> getMainGroup() {
    final jsonData = _prefs.read('mainGroup');
    return json.decode(jsonData);
  }
  static void setSubGroup(List<dynamic> subGroup) {
    Map<String, dynamic> map = {};
    for (var item in subGroup) {
      var id = item['id'].toString(); // تبدیل کلید به رشته
      map[id] = item;
    }

    String jsonMap = jsonEncode(map);
    _prefs.write('subGroup', jsonMap);
  }
  static Map<String, dynamic> getSubGroup() {
    final jsonData = _prefs.read('subGroup');
    return json.decode(jsonData);
  }

  static void setTradingHall(List<dynamic> tradingHall) {
    Map<String, dynamic> map = {};
    for (var item in tradingHall) {
      var id = item['id'].toString(); // تبدیل کلید به رشته
      map[id] = item;
    }

    String jsonMap = jsonEncode(map);
    _prefs.write('tradingHall', jsonMap);
  }
  static Map<String, dynamic> getTradingHall() {
    final jsonData = _prefs.read('tradingHall');
    return json.decode(jsonData);

  }

  static void setCompany(List<dynamic> company) {
    Map<String, dynamic> map = {};
    for (var item in company) {
      var id = item['id'].toString(); // تبدیل کلید به رشته
      map[id] = item;
    }

    String jsonMap = jsonEncode(map);
    _prefs.write('company', jsonMap);
  }
  static Map<String, dynamic> getCompany() {
    final jsonData = _prefs.read('company');
    return json.decode(jsonData);
  }

  static Future<void> clearDataSaving() async{
    return _prefs.erase();
  }
}

