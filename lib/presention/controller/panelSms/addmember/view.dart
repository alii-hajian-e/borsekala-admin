import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../widget/scrollBar.dart';
import '../../../component/header_component/header_component.dart';
import '../../../component/item_list_user/item_list_user.dart';
import '../../../component/list_user/listUser.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/string_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import 'logic.dart';

class AddMemberPage extends StatelessWidget {
  AddMemberPage({super.key});

  final logic = Get.put(AddMemberLogic());

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorManager.white,
        margin: const EdgeInsets.fromLTRB(AppMargin.m56, AppMargin.m40, AppMargin.m56, AppMargin.m0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('لیست کاربران',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s32)),
          const SizedBox(height: AppSize.s24),
          HeaderBar(
            visible: true,
            textFieldController: logic.txtSearchUser,
            icon: Icons.person_outline,
            nameBtn: 'افزودن کاربر',
            onPress: (){
              logic.dialogAddUser(
                context: context,
                txtAlert: 'اضافه کردن کاربر',
                txtBtn1: 'انصراف',
                txtBtn: 'ثبت',
              );
            },
            onChanged: (val) {
              logic.searchUser(val);
            },
          ),
          const SizedBox(height: AppSize.s8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p16),
            decoration: BoxDecoration(
              border: Border.all(width: AppSize.s1,color: ColorManager.red.withValues(alpha: 0.3)),
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
              color: ColorManager.red.withValues(alpha: 0.1),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  ImageAssets.danger,
                  width: AppSize.s24,
                  height: AppSize.s24,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(ColorManager.red, BlendMode.srcIn),
                ),
                const SizedBox(width: AppSize.s16),
                Text(AppString.alert,style: getMediumStyle(color: ColorManager.red.withValues(alpha: 0.8),fontSize: AppSize.s14),textAlign: TextAlign.start,),
              ],
            ),
          ),
          const SizedBox(height: AppSize.s16),
          Expanded(
            child: ListViewUser(
              emailTxt: 'شماره موبایل',
              activeCheckBox: false,
              isCheckedAll: false,
              onTapCheckBoxAll: (){},
              childBtnDelete: Container(),
              child: Expanded(
                child: Obx(() {
                  return ScrollBarWidget(
                    controllerScrollBar: logic.scrollController,
                    childUi: ListView.builder(
                      controller: logic.scrollController,
                      itemCount: logic.listUser.length,
                      itemBuilder: (context, index) {
                        return ItemListUser(
                          hiddenVerifyUser: true,
                          verifyUser: logic.listUser[index].isActive,
                          activeCheckBox: false,
                          itemsActive: true,
                          activeEditItem: true,
                          itemsUserName: logic.listUser[index].name ?? '',
                          itemsUserCompany: logic.listUser[index].company ?? '',
                          itemsUserPhone: logic.listUser[index].phone ?? '',
                          itemsIndex: index,
                          btnActive: false,
                          onPressDeleteItem: (){
                            logic.dialogDeleteItem(context,index);
                          },
                          onPressEditeItem: (){
                            logic.dialogEditeUser(
                              phone: logic.listUser[index].phone ?? '',
                              name: logic.listUser[index].name ?? '',
                              company: logic.listUser[index].company ?? '',
                              id: logic.listUser[index].id.toString(),
                              context: context,
                              hintTextCompany: logic.listUser[index].company ?? '',
                              hintTextName: logic.listUser[index].name ?? '',
                              hintTextPhone: logic.listUser[index].phone ?? '',
                              txtAlert: 'ویرایش کاربر',
                              txtBtn1: 'انصراف' ,
                              txtBtn: 'ذخیره',
                            );
                          },
                          onPressVerifyUser: () {
                            logic.otpUser(context: context, idUser: logic.listUser[index].id);
                            logic.accountCodeDialog(context: context, idUser: logic.listUser[index].id);
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      )
    );
  }
}
