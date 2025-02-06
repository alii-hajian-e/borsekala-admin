import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/model/admin-model.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/shared_manager.dart';
import '../../panelSms/home/logic.dart';

class HomeSettingLogic extends GetxController {

  final adminList = <AdminModel>[].obs;
  // final activeUserAdmin = false.obs;
  final AppApiPanel apiServicePanelSetting = AppApiPanel();
  final homeLogic = Get.put(HomeLogic());

  final txtEmail= TextEditingController();
  final txtFamily= TextEditingController();
  final txtName = TextEditingController();
  final txtPassword = TextEditingController();

  void getAdminList(context) async {
    try{
      final response = await apiServicePanelSetting.get(AppUrl.adminList, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        // String jsonString = jsonEncode(getResponse.body);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        adminList.clear();
        adminList.value = (response.data['results']).map<AdminModel>((json) => AdminModel.fromJson(json)).toList();
      }
    }on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void addAdminRequest(context){
    if(txtEmail.text.isNotEmpty && txtFamily.text.isNotEmpty && txtName.text.isNotEmpty && txtPassword.text.isNotEmpty){
      addAdmin(context,data: {
        // 'username': txtEmail.text.toString(),
        'password': txtPassword.text.toString(),
        'email': txtEmail.text.toString(),
        'family': txtFamily.text.toString(),
        'name': txtName.text.toString(),
      });
    } else {
      Alert(txt: 'اطلاعات وارد شده اشتباه یا خالی است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> addAdmin (context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanelSetting.post(url: AppUrl.adminList, data: data ,options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 201){
        GoRouter.of(context).pop();
        txtEmail.clear();
        txtFamily.clear();
        txtName.clear();
        txtPassword.clear();
        getAdminList(context);
      }
    } on DioException catch (e){
      if(e.response?.statusCode == 400) {
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }else{
        Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    }
  }
  void updaterAdmin({id, name, family, email, active, context}){
    // print({
    //   'email': txtEmail.text.isEmpty ? email : txtEmail.text,
    //   'family': txtFamily.text.isEmpty ? family : txtFamily.text,
    //   'name': txtName.text.isEmpty ? name : txtName.text,
    //   'is_active': active,
    // });
    updateUserAdmin(id,context, data: {
      // 'username': txtEmail.text.isEmpty ? email : txtEmail.text,
      'email': txtEmail.text.isEmpty ? email : txtEmail.text,
      'family': txtFamily.text.isEmpty ? family : txtFamily.text,
      'name': txtName.text.isEmpty ? name : txtName.text,
      'is_active': active,
    });
  }
  Future<void> updateUserAdmin (id, context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanelSetting.patch(url: '${AppUrl.adminList}$id/', data: data ,options:
      Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        txtEmail.clear();
        txtFamily.clear();
        txtName.clear();
        adminList.clear();
        getAdminList(context);
      }
    } on DioException catch (e){
      if(e.response?.statusCode == 400) {
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }else{
        Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    }
  }

  void deleteAdminList(id,context) async {
    try{
      final response = await apiServicePanelSetting.delete('${AppUrl.adminList}$id/', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 204){
        GoRouter.of(context).pop();
        getAdminList(context);
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

}
