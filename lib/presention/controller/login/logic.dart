
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:bors_web_admin_sms/dataurl/data/network/api/app_api_panel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/constants/app_url_DB.dart';
import '../../../dataurl/data/model/login-model.dart';
import '../../../dataurl/data/network/api/app_api.dart';
import '../../component/alert/alert.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';
import '../../resources/string_manager.dart';

class LoginLogic extends GetxController with StateMixin<List<VerifyModel>>{
  final AppApi apiService = AppApi();
  final AppApiPanel apiServicePanel = AppApiPanel();
  final txtUserName = TextEditingController();
  final txtPassword = TextEditingController();
  final loading = false.obs;
  final eye = true.obs;
  final FocusNode focusNode = FocusNode();
  final pageManufacturer = 1.obs;
  final manufacturerList = [].obs;
  final loadingPanel = false.obs;

  @override
  void onInit() async{
    super.onInit();
    loadingPanel.value = true;
    await uploadDate(context);
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
  void loginRequest(context) async{
    loading.value = true;
    if(txtUserName.text.isNotEmpty && txtPassword.text.isNotEmpty){
      login(data: {'username': txtUserName.text.toString(),'password': txtPassword.text.toString()},context: context);
    } else {
      loading.value = false;
      Alert(txt: AppString.errorField, color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> login ({Map<String, dynamic>? data, context}) async{
    try{
      final response = await apiServicePanel.post(url: AppUrl.login,data: data ,
          options: Options(headers:{'Content-Type': 'application/x-www-form-urlencoded'}));
      if(response.statusCode == 200){
        final dataVerify = VerifyModel.fromJson(response.data);
          MyPreferences.setToken(dataVerify.access!);
          loading.value = false;
          GoRouter.of(context).pushReplacement('/landingPage');
      }else{
        loading.value = false;
        Alert(txt: 'اطلاعات وارد شده اشتباه است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    } on DioException catch (e){
      loading.value = false;
      Alert(txt: 'اطلاعات وارد شده اشتباه است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> uploadDate(context)async {
    await group(context);
    await mainGroup(context);
    await subGroup(context);
    await tradingHall(context);
    await fetchManufacturerList(context);
  }
  Future<void> group(context) async {
    try {
      final response = await apiService.get(AppUrlDB.group, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if (response.statusCode == 200) {
        MyPreferences.setGroup(response.data);
      }
    } on DioException catch (e) {
      Alert(txt: 'اطلاعات دریافت نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> mainGroup(context) async {
    try{
      final response = await apiService.get(AppUrlDB.mainGroup, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if(response.statusCode == 200){
        MyPreferences.setMainGroup(response.data);
      }
    } on DioException catch (e){
      Alert(txt: 'اطلاعات دریافت نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> subGroup(context) async {
    try{
      final response = await apiService.get(AppUrlDB.subGroup, Options(headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if(response.statusCode == 200){
        MyPreferences.setSubGroup(response.data);
      }
    } on DioException catch (e){
      Alert(txt: 'اطلاعات دریافت نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> tradingHall(context) async {
    try{
      final response = await apiService.get(AppUrlDB.tradingHallMenuSubGroup, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if(response.statusCode == 200){
        // String jsonString = jsonEncode(response.data);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        MyPreferences.setTradingHall(response.data);
      }
    } on DioException catch (e){
      Alert(txt: 'اطلاعات دریافت نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> fetchManufacturerList(context) async {
    try {
      final response = await apiService.get('${AppUrlDB.manufacturerUrl}?page=${pageManufacturer.value}', Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if(response.statusCode == 200){
        var next = response.data['next'];
        if (next == null) {
          loadingPanel.value = false;
          MyPreferences.setCompany(manufacturerList);
          return;
        } else {
          pageManufacturer.value ++;
          manufacturerList.addAll(response.data['results']);
          fetchManufacturerList(context);
        }
      }
    } on DioException catch (e) {
      Alert(txt: 'اطلاعات دریافت نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
}