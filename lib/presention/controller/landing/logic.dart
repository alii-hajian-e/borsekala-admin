
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:get/get.dart';
import '../login/logic.dart';
import '../panelSetting/homeSetting/logic.dart';
import '../panelSms/addmember/logic.dart';
import '../panelSms/home/logic.dart';

class LandingLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());
  final loginLogic = Get.put(LoginLogic());
  final homeSettingLogic = Get.put(HomeSettingLogic());

  @override
  void onInit() {
    homeSettingLogic.getAdminList(context);
    super.onInit();
  }
}
