// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/data/model/grouplistmodel.dart';
import '../../../dataurl/data/model/user-model-group.dart';
import '../../../dataurl/data/network/service/api_service.dart';
import '../../component/alert/alert.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';

class HomeLogic extends GetxController with StateMixin<dynamic>{

  final groupList = <GroupList>[].obs;
  final groupListSearch = <GroupList>[].obs;
  final txtSearch = TextEditingController();
  final txtSearchUser = TextEditingController();
  ApiService apiService = ApiService();
  var isCheckedList = <Model>[].obs;
  var isCheckedListSearch = <Model>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPanelRoom(context);
  }

  void getPanelRoom(context) async {
    try{
      final response = await apiService.get(AppUrl.panelRoom,options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        // String jsonString = jsonEncode(getResponse.body);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        groupList.clear();
        groupListSearch.clear();
        groupList.value = (response.data['results']).map<GroupList>((json) => GroupList.fromJson(json)).toList();
        groupListSearch.value = (response.data['results']).map<GroupList>((json) => GroupList.fromJson(json)).toList();
      }
    }on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void sendSMS(id,context) async {
    try{
      final response = await apiService.get('${AppUrl.sendSms}$id', options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 204){
        Alert(txt: 'پیامک تستی ارسال شد', color: ColorManager.black, backgroundColor: ColorManager.yellow).showSnackBar(context);
      }
    }on DioException catch (e){
      Alert(txt: 'پیامک تستی ارسال نشد', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void searchUser(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = isCheckedListSearch.where((all) {
        final name = all.user.name.toLowerCase();
        return name.contains(input);
      }).toList();
      isCheckedList.clear();
      isCheckedList.addAll(suggestions);
    } else {
      isCheckedList.clear();
      isCheckedList.addAll(isCheckedListSearch);
    }
  }
  void search(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = groupListSearch.where((all) {
        final name = all.name!.toLowerCase();
        return name.contains(input);
      }).toList();
      groupList.clear();
      groupList.addAll(suggestions);
    } else {
      groupList.clear();
      groupList.addAll(groupListSearch);
    }
  }
  Future<void> listUser (id,context) async{
    try{
      final response = await apiService.get('${AppUrl.userGroupList}?room=$id', options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}"
      }));
      if(response.statusCode == 200){
        // String jsonString = jsonEncode(response.data['results']);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        isCheckedList.clear();
        isCheckedListSearch.clear();
        isCheckedList.value = response.data['results'].map<Model>((json) => Model.fromJson(json)).toList();
        isCheckedListSearch.value = response.data['results'].map<Model>((json) => Model.fromJson(json)).toList();
      }
    }on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

}
