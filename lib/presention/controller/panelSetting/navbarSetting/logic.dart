
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../../main.dart';
import '../../../component/alert/alert.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/shared_manager.dart';
import '../homeSetting/logic.dart';


class NavbarSettingLogic extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldSettingKey = GlobalKey<ScaffoldState>();
  final selected = 0.obs;
  final selectedIndex = true.obs;
  final selectedIndex1 = false.obs;
  final selectedIndex2 = false.obs;
  final selectedIndex3 = false.obs;
  ScrollController scrollController = ScrollController();
  final homeSettingLogic = Get.put(HomeSettingLogic());
  final AppApiPanel apiServicePanelSetting = AppApiPanel();
  final nameAdmin = ''.obs;
  final familyAdmin = ''.obs;

  @override
  void onInit() async{
    homeSettingLogic.getAdminList(context);
    await getAdminProfile(context);
    super.onInit();
  }

  Future<void> getAdminProfile(context) async {
    try{
      final response = await apiServicePanelSetting.get(AppUrl.profileAdmin, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        nameAdmin.value = response.data['name'];
        familyAdmin.value = response.data['family'];
        print('SHHHHHHHHHHHH');
        print(nameAdmin.value);
        print(nameAdmin.value);
      }
    }on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void changeIndex(int index){
    selected.value = index;
  }

}
