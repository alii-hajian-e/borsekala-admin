// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/data/model/user-list-model.dart';
import '../../../dataurl/data/network/api/app_api_panel.dart';
import '../../component/alert/alert.dart';
import '../../component/dialog_component/dialog_action/dialod_action.dart';
import '../../component/dialog_component/dialog_add_delete_user/dialog_add_delete_user.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';
import '../home/logic.dart';

class AddMemberLogic extends GetxController {

  final listUser = <ModelUser>[].obs;
  final listUserSearch = <ModelUser>[].obs;
  final txtSearchUser = TextEditingController();
  final homeLogic = Get.put(HomeLogic());

  final txtNameUser= TextEditingController();
  final txtFamilyUser = TextEditingController();
  final txtPhoneUser = TextEditingController();

  final AppApiPanel apiServicePanel = AppApiPanel();

  @override
  void onInit() {
    super.onInit();
    getUserList(context);
  }

  void getUserList(context) async {
    try{
      final response = await apiServicePanel.get(AppUrl.userList, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        listUser.clear();
        listUserSearch.clear();
        listUser.value = response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList();
        listUserSearch.value = response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList();
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void deleteUserList(id,context) async {
    try{
      final response = await apiServicePanel.delete('${AppUrl.userList}$id/', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 204){
        GoRouter.of(context).pop();
        getUserList(context);
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void addUserRequest(context){
    if(txtNameUser.text.isNotEmpty && txtFamilyUser.text.isNotEmpty && txtPhoneUser.text.isNotEmpty){
      addUser(context,data: {'name': txtNameUser.text.toString(),'family': txtFamilyUser.text.toString(),'phone': txtPhoneUser.text.toString()});
    } else {
      Alert(txt: 'اطلاعات وارد شده اشتباه یا خالی است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> addUser (context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanel.post(url: AppUrl.userList, data: data ,options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
          }));
      if(response.statusCode == 201){
        GoRouter.of(context).pop();
        txtNameUser.clear();
        txtFamilyUser.clear();
        txtPhoneUser.clear();
        getUserList(context);
      }else if(response.statusCode == 400){
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void updateUserRequest({id, name, family, phone, context}){
    updateUser(id,context, data: {
      'name': txtNameUser.text.isEmpty ? name : txtNameUser.text,
      'family': txtFamilyUser.text.isEmpty ? family : txtFamilyUser.text,
      'phone': txtPhoneUser.text.isEmpty ? phone : txtPhoneUser.text,
    });
  }
  Future<void> updateUser (id, context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanel.patch(url: '${AppUrl.userList}$id/', data: data ,options:
          Options(headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            "authorization": "Bearer ${MyPreferences.getToken()}",
          }));
      if(response.statusCode == 200){
        txtNameUser.clear();
        txtFamilyUser.clear();
        txtPhoneUser.clear();
        getUserList(context);
        GoRouter.of(context).pop();
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void searchUser(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = listUserSearch.where((all) {
        final name = all.name.toLowerCase();
        return name.contains(input);
      }).toList();
      listUser.clear();
      listUser.addAll(suggestions);
    } else {
      listUser.clear();
      listUser.addAll(listUserSearch);
    }
  }
  void dialogDeleteItem(context,index){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.trash),
          txtAlert: 'این کاربر حذف شود ؟',
          txtBtn1: 'خیر',
          txtBtn: 'بله',
          onPress: () {
            deleteUserList(listUser[index].id,context);
          },
          onPress1: (){
            // GoRouter.of(context).pop();
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }
  void dialogAddUser(context,String txtAlert,String txtBtn,String txtBtn1){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_DeleteUser(
          hintTextFamily: 'نام خانوادگی را وارد کنید',
          hintTextName: 'نام را وارد کنید',
          hintTextPhone: '#### ### ## ##',
          buttonColorBtn1: ColorManager.gray1,
          buttonColorBtn: ColorManager.yellow,
          textFieldControllerFamily: txtFamilyUser,
          textFieldControllerName: txtNameUser,
          textFieldControllerPhone: txtPhoneUser,
          txtAlert: txtAlert,
          txtBtn1: txtBtn1,
          txtBtn: txtBtn,
          onPress: () {
            addUserRequest(context);
          },
          onPress1: (){
            txtNameUser.clear();
            txtFamilyUser.clear();
            txtPhoneUser.clear();
            // GoRouter.of(context).pop();
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }
  void dialogEditeUser({context, hintTextName, hintTextFamily, hintTextPhone, txtAlert, txtBtn, txtBtn1, id, family ,name ,phone}){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_DeleteUser(
          hintTextName: hintTextName,
          hintTextFamily: hintTextFamily,
          hintTextPhone: hintTextPhone,
          buttonColorBtn1: ColorManager.gray1,
          buttonColorBtn: ColorManager.yellow,
          textFieldControllerFamily: txtFamilyUser,
          textFieldControllerName: txtNameUser,
          textFieldControllerPhone: txtPhoneUser,
          txtAlert: txtAlert,
          txtBtn1: txtBtn1,
          txtBtn: txtBtn,
          onPress: () {
            updateUserRequest(
              context: context,
              id: id,
              family: family,
              name: name,
              phone: phone,
            );
          },
          onPress1: (){
            txtNameUser.clear();
            txtFamilyUser.clear();
            txtPhoneUser.clear();
            // GoRouter.of(context).pop();

            Navigator.of(context).pop();
          },
        );

      },
    );
  }

}
