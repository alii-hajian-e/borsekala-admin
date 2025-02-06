class AppUrl {

  // base url
  static const String baseUrl = "https://panel.ibrokers.ir";
  // static const String baseUrl = "https://testpanel.ibrokers.ir";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  static const String panelRoom = '$baseUrl/panel/api/v1/rooms/';
  static const String userGroupList = '$baseUrl/panel/api/v1/user-groups';
  static const String addUserGroup = '$baseUrl/panel/api/v1/gorups';

  static const String login = '$baseUrl/account/api/v1/login/';
  static const String userList = '$baseUrl/panel/api/v1/users/';
  static const String sendSms = '$baseUrl/panel/api/v1/test/';
  static const String otp = '$baseUrl/panel/api/v1/otp/';

  static const String adminList = '$baseUrl/account/api/v1/users/';
  static const String profileAdmin = '$baseUrl/account/api/v1/profile/';
  static const String downloadFile = '$baseUrl/generator/generate-file/';

  static const String tickets = '$baseUrl/ticket/api/v1/tickets/';
  static const String ticket = '$baseUrl/ticket/api/v1/ticket/';
  static const String category = '$baseUrl/ticket/api/v1/category/';
}
