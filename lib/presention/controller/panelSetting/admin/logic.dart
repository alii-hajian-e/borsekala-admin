import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../component/dialog_component/dialog_action/dialod_action.dart';
import '../../../component/dialog_component/dialog_add_update/dialog_add_update.dart';
import '../../../component/input_component/defult/defulttextfield.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../homeSetting/logic.dart';

class AdminLogic extends GetxController {
  final homeSettingLogic = Get.put(HomeSettingLogic());

  void dialogAddAdmin(context,String txtAlert,String txtBtn,String txtBtn1){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_UpdateAdmin(
          txtFamily: 'نام خانوادگی',
          txtName: 'نام',
          txtPhoneEmail: 'ایمیل',
          hintTextFamily: 'نام خانوادگی را وارد کنید',
          hintTextName: 'نام را وارد کنید',
          hintTextPhone: 'info@ibrokers.ir',
          buttonColorBtn1: ColorManager.gray1,
          buttonColorBtn: ColorManager.yellow,
          textFieldControllerFamily: homeSettingLogic.txtFamily,
          textFieldControllerName: homeSettingLogic.txtName,
          textFieldControllerPhone: homeSettingLogic.txtEmail,
          txtAlert: txtAlert,
          txtBtn1: txtBtn1,
          txtBtn: txtBtn,
          onPress: () {
            homeSettingLogic.addAdminRequest(context);
          },
          onPress1: (){
            homeSettingLogic.txtFamily.clear();
            homeSettingLogic.txtName.clear();
            homeSettingLogic.txtEmail.clear();
            // GoRouter.of(context).pop();

            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              const SizedBox(height: AppSize.s16),
              Align(
                alignment: Alignment.centerRight,
                child: Text('رمز عبور', style: getBoldStyle(
                    color: ColorManager.black, fontSize: AppSize.s14)),
              ),
              const SizedBox(height: AppSize.s16),
              SizedBox(
                height: AppSize.s48,
                child: DefaultTextField(
                  obscureText: false,

                  textFieldColor: ColorManager.white,
                  textInputType: TextInputType.text,
                  borderSideWidth: AppSize.s2,
                  borderSideColor: ColorManager.gray1,
                  hintStyle: getMediumStyle(
                      color: ColorManager.black, fontSize: AppSize.s14),
                  hintText: 'رمز عبور خود را وارد کنید',
                  textFieldActive: false,
                  textFieldController: homeSettingLogic.txtPassword,
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void dialogUpdateAdmin(context,String txtAlert,String txtBtn,String txtBtn1,id,email,family,name){
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_UpdateAdmin(
          txtFamily: 'نام خانوادگی',
          txtName: 'نام',
          txtPhoneEmail: 'ایمیل',
          hintTextFamily: family,
          hintTextName: name,
          hintTextPhone: email,
          buttonColorBtn1: ColorManager.gray1,
          buttonColorBtn: ColorManager.yellow,
          textFieldControllerFamily: homeSettingLogic.txtFamily,
          textFieldControllerName: homeSettingLogic.txtName,
          textFieldControllerPhone: homeSettingLogic.txtEmail,
          txtAlert: txtAlert,
          txtBtn1: txtBtn1,
          txtBtn: txtBtn,
          onPress: () {
            homeSettingLogic.updateUserAdmin(id,context, data: {
              // 'username': homeSettingLogic.txtEmail.text.isEmpty ? email : homeSettingLogic.txtEmail.text,
              'email': homeSettingLogic.txtEmail.text.isEmpty ? email : homeSettingLogic.txtEmail.text,
              'family': homeSettingLogic.txtFamily.text.isEmpty ? family : homeSettingLogic.txtFamily.text,
              'name': homeSettingLogic.txtName.text.isEmpty ? name : homeSettingLogic.txtName.text,
            });
            GoRouter.of(context).pop();
          },
          onPress1: (){
            homeSettingLogic.txtFamily.clear();
            homeSettingLogic.txtName.clear();
            homeSettingLogic.txtEmail.clear();
            // GoRouter.of(context).pop();

            Navigator.of(context).pop();
          },
          child: Container(),
        );
      },
    );
  }

  void dialogDeleteAdmin(context,index){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown, ImageAssets.trash),
          txtAlert: 'این ادمین حذف شود ؟',
          txtBtn1: 'خیر',
          txtBtn: 'بله',
          onPress: () {
            homeSettingLogic.deleteAdminList(homeSettingLogic.adminList[index].id, context);
          },
          onPress1: (){
            // GoRouter.of(context).pop();
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }

}
