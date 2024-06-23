// ignore_for_file: file_names

class AppUrlDB {

  // base url
  static const String baseUrl = "https://api.ibrokers.ir";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;


  static const String group = '$baseUrl/bourse/group/group';
  static const String mainGroup = '$baseUrl/bourse/group/main-group';
  static const String subGroup = '$baseUrl/bourse/group/sub-group';
  static const String tradingHallMenuSubGroup = '$baseUrl/bourse/trading-hall/menu-sub-group';
  static const String manufacturerUrl = '$baseUrl/bourse/manufacturers/';


}
