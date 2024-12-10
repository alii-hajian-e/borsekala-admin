// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/model/user-list-model.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../component/button_component/org-btn/wid_button.dart';
import '../../../component/dialog_component/dialog_action/dialod_action.dart';
import '../../../component/dialog_component/dialog_add_delete_user/dialog_add_delete_user.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/shared_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/value_manager.dart';
import '../home/logic.dart';

class AddMemberLogic extends GetxController  with StateMixin<List<dynamic>>{

  final listUser = <ModelUser>[].obs;
  final listUserSearch = <ModelUser>[].obs;
  final txtSearchUser = TextEditingController();
  final homeLogic = Get.put(HomeLogic());

  final txtNameUser= TextEditingController();
  final txtFamilyUser = TextEditingController();
  final txtPhoneUser = TextEditingController();
  final txtCodeUser = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final pageUserGroup = 1.obs;

  final AppApiPanel apiServicePanel = AppApiPanel();

  @override
  void onInit() {
    super.onInit();
    pageUserGroup.value = 1;
    getUserList(context);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  void getUserList(context) async {
    try{
      final response = await apiServicePanel.get('${AppUrl.userList}?page=${pageUserGroup.value}', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        if(pageUserGroup.value == 1){
          listUser.clear();
          listUserSearch.clear();
        }
        var next = response.data['next'];
        if (next == null) {
          listUser.addAll(response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList());
          listUserSearch.addAll(response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList());
          return;
        } else {
          pageUserGroup.value ++;
          listUser.addAll(response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList());
          listUserSearch.addAll(response.data['results'].map<ModelUser>((json) => ModelUser.fromJson(json)).toList());
          getUserList(context);
        }
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
        pageUserGroup.value = 1;
        getUserList(context);
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void addUserRequest(context){
    if(txtNameUser.text.isNotEmpty && txtFamilyUser.text.isNotEmpty && txtPhoneUser.text.isNotEmpty){
      addUser(context,data: {'name': txtNameUser.text.toString(),'company': txtFamilyUser.text.toString(),'phone': txtPhoneUser.text.toString()});
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
        pageUserGroup.value = 1;
        getUserList(context);
      }
    } on DioException catch (e){
      if(e.response?.statusCode == 400) {
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }else{
        Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    }
  }
  void updateUserRequest({id, name, family, phone, context}){
    // if(txtNameUser.text.isNotEmpty && txtFamilyUser.text.isNotEmpty && txtPhoneUser.text.isNotEmpty){
      updateUser(id,context, data: {
        'name': txtNameUser.text.isEmpty ? name : txtNameUser.text,
        'company': txtFamilyUser.text.isEmpty ? family : txtFamilyUser.text,
        'phone': txtPhoneUser.text.isEmpty ? phone : txtPhoneUser.text,
      });
    // } else {
    //   Alert(txt: 'اطلاعات وارد شده اشتباه یا خالی است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    // }
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
        pageUserGroup.value = 1;
        getUserList(context);
        GoRouter.of(context).pop();
      }
    } on DioException catch (e){
      if(e.response?.statusCode == 400) {
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }else{
        Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }    }
  }

  void otpUser({context,idUser}) async {
    try{
      final response = await apiServicePanel.get('${AppUrl.otp}$idUser', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){}
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void addOtpUser({context, code,idUser}){
    if(txtCodeUser.text.isNotEmpty){
      otpUserCode(context,idUser,data: {'otp': code});
    } else {
      Alert(txt: 'اطلاعات وارد شده اشتباه یا خالی است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> otpUserCode (context,idUser,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanel.post(url: '${AppUrl.otp}$idUser', data: data ,options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        pageUserGroup.value = 1;
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
        final name = all.name!.toLowerCase();
        final phone = all.phone!.toLowerCase();
        return name.contains(input) || phone.contains(input);
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
          icons: SvgPicture.asset(fit: BoxFit.scaleDown, ImageAssets.trash),
          txtAlert: 'در صورت حذف کاربر از تمام گروه ها حذف خواهد شد',
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
  void dialogAddUser(
      {required BuildContext context,
        required String txtAlert,
        required String txtBtn,
        required String txtBtn1,
      }){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_DeleteUser(
          txtCompany: 'نام شرکت',
          txtName: 'نام نام خانوادگی',
          txtPhoneEmail: 'شماره موبایل',
          hintTextCompany: 'نام شرکت را وارد کنید',
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
  void dialogEditeUser({
    required BuildContext context,
    required String hintTextName,
    required String hintTextCompany,
    required String hintTextPhone,
    required String txtAlert,
    required String company ,
    required String name ,
    required String phone,
    required String txtBtn,
    required String txtBtn1,
    required String id,
  }){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_DeleteUser(
          txtCompany: 'نام شرکت',
          txtName: 'نام نام خانوادگی',
          txtPhoneEmail: 'شماره موبایل',
          hintTextName: hintTextName,
          hintTextCompany: hintTextCompany,
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
              family: company,
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
  Future<void> accountCodeDialog({required BuildContext context, idUser}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorManager.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(AppSize.s16),
            ),
          ),
          surfaceTintColor: ColorManager.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Container(
              width: MediaQuery.of(context).size.width / 3,
              margin: const EdgeInsets.symmetric(
                horizontal: AppMargin.m24,
                vertical: AppMargin.m24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: AppPadding.p8),
                    child: Text(AppString.dialogVerifyUserInCode,
                        style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: AppSize.s14)),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: PinCodeTextField(
                      backgroundColor: ColorManager.white,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      length: 4,
                      boxShadows: [
                        BoxShadow(
                            blurRadius: 0,
                            offset: const Offset(0, 0),
                            color: ColorManager.gray,
                            spreadRadius: 0)
                      ],
                      controller: txtCodeUser,
                      autoDisposeControllers: false,
                      autoFocus: true,
                      onChanged: (value) {},
                      cursorColor: ColorManager.black,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(AppSize.s8),
                        fieldHeight: AppSize.s48,
                        fieldWidth: AppSize.s64,
                        inactiveColor: ColorManager.black.withOpacity(0.4),
                        borderWidth: AppSize.s05,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: WidgetButton(
                          borderSideColor: ColorManager.yellow,
                          height: AppSize.s48,
                          buttonTextColor: ColorManager.black,
                          buttonColor: ColorManager.yellow,
                          buttonText: 'ارسال کد',
                          buttonOnPressed: () {
                            addOtpUser(context: context,code: txtCodeUser.text,idUser: idUser);
                          },
                          fontSize: AppSize.s16,
                          borderRadius: AppSize.s8,
                        ),
                      ),
                      Expanded(
                        child: WidgetButton(
                          borderSideColor: ColorManager.white,
                          height: AppSize.s48,
                          buttonTextColor: ColorManager.black,
                          buttonColor: ColorManager.white,
                          buttonText: 'بازگشت',
                          buttonOnPressed: () => GoRouter.of(context).pop(),
                          fontSize: AppSize.s16,
                          borderRadius: AppSize.s8,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }

}
