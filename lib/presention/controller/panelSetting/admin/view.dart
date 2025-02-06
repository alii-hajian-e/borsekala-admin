import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/header.dart';
import '../../../component/button_component/select-btn/select-bn.dart';
import '../../../component/item_list_user/item_list_user.dart';
import '../../../component/list_user/listUser.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../navbarSetting/logic.dart';
import 'logic.dart';

class AdminPage extends StatelessWidget {
  AdminPage({super.key});

  final logic = Get.put(AdminLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorManager.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s56,
              vertical: AppPadding.p32,
            ),
            child: Column(
              children: [
                Obx(() {
                  final navbarSettingLogic = Get.put(NavbarSettingLogic());
                  return Header(
                      txtHeader: '${navbarSettingLogic.nameAdmin.value} ${navbarSettingLogic.familyAdmin.value}');
                }),
                const SizedBox(height: AppSize.s24),
                Expanded(
                  child: ListViewUser(
                    emailTxt: 'ایمیل',
                    activeCheckBox: false,
                    isCheckedAll: false,
                    childBtnDelete: SelectBtn(
                      appPaddingSelect: AppPadding.p16,
                      appSizeBtn: AppSize.s14,
                      mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                      visibleSelect: false,
                      iconSelect: Icon(
                          Icons.person_2_outlined, color: ColorManager.black,
                          size: AppSize.s18),
                      onPress: () {
                        logic.dialogAddAdmin(
                            context, 'افزودن ادمین', 'ذخیره', 'انصراف');
                      },
                      text: 'افزودن امین',
                      borderColor: ColorManager.white.withOpacity(0),
                      radius: AppSize.s8,
                      heightBtn: AppSize.s48,
                      colorTextSelect: ColorManager.black,
                      backgroundColorSelect: ColorManager.gray1,
                    ),
                    child: Expanded(
                      child: Obx(() {
                        return ListView.builder(
                          itemCount: logic.homeSettingLogic.adminList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return ItemListUser(
                                hiddenVerifyUser: false,
                                verifyUser: false,
                                activeCheckBox: false,
                                itemsActive: true,
                                activeEditItem: true,
                                itemsUserName: logic.homeSettingLogic
                                    .adminList[index].name ?? '',
                                itemsUserCompany: logic.homeSettingLogic
                                    .adminList[index].family ?? '',
                                itemsUserPhone: logic.homeSettingLogic
                                    .adminList[index].email ?? '',
                                itemsIndex: index,
                                btnActive: true,
                                colorBtnActiveAdmin: !logic.homeSettingLogic
                                    .adminList[index].isActive
                                    ? ColorManager.red2
                                    : ColorManager.green,
                                colorTextBtnActiveAdmin: ColorManager.white,
                                txtActiveBtnAdmin: !logic.homeSettingLogic
                                    .adminList[index].isActive ?
                                'غیر فعال' :
                                'فعال',
                                onPressDeleteItem: () {
                                  logic.dialogDeleteAdmin(context, index);
                                },
                                onPressEditeItem: () {
                                  logic.dialogUpdateAdmin(
                                    context,
                                    'ویرایش ادمین',
                                    'ذخیره',
                                    'انصزاف',
                                    logic.homeSettingLogic.adminList[index].id,
                                    logic.homeSettingLogic.adminList[index]
                                        .email,
                                    logic.homeSettingLogic.adminList[index]
                                        .family,
                                    logic.homeSettingLogic.adminList[index]
                                        .name,
                                  );
                                },
                                onPressBtnActiveAdmin: () {
                                  // logic.homeSettingLogic.activeUserAdmin.value =
                                  // !logic.homeSettingLogic.activeUserAdmin.value;
                                  logic.homeSettingLogic.updaterAdmin(
                                    active: !logic.homeSettingLogic.adminList[index].isActive,
                                    context: context,
                                    family: logic.homeSettingLogic.adminList[index].family,
                                    id: logic.homeSettingLogic.adminList[index].id,
                                    name: logic.homeSettingLogic.adminList[index].name,
                                    email: logic.homeSettingLogic.adminList[index].email,
                                  );
                                },
                              );
                            });
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
