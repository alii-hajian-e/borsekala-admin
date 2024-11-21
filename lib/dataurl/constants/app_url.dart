class AppUrl {

  // base url
  static const String baseUrl = "https://panel.ibrokers.ir";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String panelRoom = '$baseUrl/panel/api/v1/rooms';
  static const String userGroupList = '$baseUrl/panel/api/v1/user-groups';
  static const String addUserGroup = '$baseUrl/panel/api/v1/groups';

  static const String login = '$baseUrl/account/api/login/';
  static const String userList = '$baseUrl/panel/api/v1/users/';
  static const String sendSms = '$baseUrl/panel/api/v1/test/';
  static const String chatList = '$baseUrl/chat/api/v1/';
}
