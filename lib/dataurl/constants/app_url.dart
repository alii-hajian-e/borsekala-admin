class AppUrl {

  // base url
  static const String baseUrl = "https://panel.ibrokers.ir";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String panelRoom = '$baseUrl/api/panel/rooms/';
  static const String login = '$baseUrl/api/account/login/';
  static const String userGroupList = '$baseUrl/api/panel/user-groups/';
  static const String addUserGroup = '$baseUrl/api/panel/gorups/';
  static const String userList = '$baseUrl/api/panel/users/';
  static const String chatList = '$baseUrl/api/chat/';
  static const String sendSms = '$baseUrl/api/panel/test/';
}
