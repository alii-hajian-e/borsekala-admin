
import 'package:bors_web_admin_sms/dataurl/data/model/group-model.dart';
import 'package:bors_web_admin_sms/dataurl/data/model/main-group-model.dart';
import 'package:bors_web_admin_sms/dataurl/data/model/sub-group-model.dart';
import 'package:bors_web_admin_sms/dataurl/data/model/trading-hall-model.dart';

import '../../../presention/resources/shared_manager.dart';

class GetDateGroupApi{
  Group findGroupById(groupId) {
    var groupListDB = MyPreferences.getGroup();
    return Group.fromJson(groupListDB[groupId.toString()]);
  }
  MainGroup findMainGroupById(mainGroupId) {
    var mainGroupListDB = MyPreferences.getMainGroup();
    return MainGroup.fromJson(mainGroupListDB[mainGroupId.toString()]);
  }
  SubGroup findSubGroupById(subGroupId) {
    var subGroupListDB = MyPreferences.getSubGroup();
    return SubGroup.fromJson(subGroupListDB[subGroupId.toString()]);
  }
  TradingHall findTradingHallById(tradingHallId) {
    var tradingHallListDB = MyPreferences.getTradingHall();
    return TradingHall.fromJson(tradingHallListDB[tradingHallId.toString()]);
  }
  Company findCompanyById(companyId) {
    var companyListDB = MyPreferences.getCompany();
    return Company.fromJson(companyListDB[companyId.toString()]);
  }
}