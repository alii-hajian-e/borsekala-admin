
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/constants/app_url_DB.dart';
import '../../../dataurl/data/model/login-model.dart';
import '../../../dataurl/data/network/service/api_service.dart';
import '../../component/alert/alert.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';
import '../../resources/string_manager.dart';

class LoginLogic extends GetxController with StateMixin<List<VerifyModel>>{
  ApiService apiService = ApiService();
  final txtUserName = TextEditingController();
  final txtPassword = TextEditingController();
  final loading = false.obs;
  final eye = true.obs;
  final FocusNode focusNode = FocusNode();
  final pageManufacturer = 1.obs;
  final manufacturerList = [].obs;

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
    await uploadDate(context);
  }
  Future<void> login ({Map<String, dynamic>? data, context}) async{
    try{
      final response = await apiService.post(AppUrl.login,data: data ,
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
      final response = await apiService.get(AppUrlDB.group, options: Options(headers: {
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
      final response = await apiService.get(AppUrlDB.mainGroup,options: Options(headers: {
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
      final response = await apiService.get(AppUrlDB.subGroup, options: Options(headers:{
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
      final response = await apiService.get(AppUrlDB.tradingHallMenuSubGroup, options: Options(headers: {
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
      final response = await apiService.get('${AppUrlDB.manufacturerUrl}?page=${pageManufacturer.value}', options: Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
      }));
      if(response.statusCode == 200){
        var next = response.data['next'];
        if (next == null) {
          MyPreferences.setCompany(response.data['results']);
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