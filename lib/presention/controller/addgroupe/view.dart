import 'package:bors_web_admin_sms/presention/component/button_component/white-btn/white_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../dataurl/data/model/user-model-group.dart';
import '../../component/button_component/btn/_btn.dart';
import '../../component/gridview_component/gridview.dart';
import '../../component/header_component/header_component.dart';
import '../../component/item_list_user/item_list_user.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import 'logic.dart';

class AddGroupPage extends StatelessWidget {
  AddGroupPage({super.key});

  final logic = Get.put(AddGroupLogic());


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: ColorManager.white,
        margin: const EdgeInsets.fromLTRB(
            AppMargin.m56, AppMargin.m40, AppMargin.m56, AppMargin.m0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('افزودن گروه', style: getBoldStyle(
                color: ColorManager.black, fontSize: AppSize.s32)),
            const SizedBox(height: AppSize.s24),
            HeaderBar(
              visible: true,
              textFieldController: logic.homeLogic.txtSearchUser,
              icon: Icons.person_outline,
              nameBtn: 'افزودن گروه',
              onPress: () {
                logic.txtNameUser.clear();
                logic.idTradingList.value = 0;
                logic.nameMainCategoryList.value = 'انتخاب کنید';
                logic.nameCategoryList.value = 'انتخاب کنید';
                logic.nameSubCategoryListString.value = 'انتخاب کنید';
                logic.nameCompanyListString.value = 'انتخاب کنید';
                logic.nameSubCategoryList.value = [];
                logic.nameCompanyList.value = [];
                logic.idMainCategoryList.value = 0;
                logic.idCategoryList.value = 0;
                logic.idSubCategoryList.value = [];
                logic.idCompanyList.value = [];
                logic.idSelectList.value = 100;
                logic.idTradingList.value = 100;
                logic.fetchTradingHallList();
                logic.fetchCompanyList();
                logic.dialogAddGroup(
                    context,
                    hintText: 'افزودن گروه',
                    txtAlert: 'نام گروه',
                    txtBtn1: 'انصراف',
                  btn: Obx(() {
                    return !logic.load.value ? Expanded(
                      child: Btn(
                        buttonColorBtn: ColorManager.yellow,
                        onPress: (){
                          logic.addGroupRequest(context);
                        },
                        text: 'ثبت',
                        heightBtn: AppSize.s48,
                        borderRadiusBtn: AppSize.s8,
                        buttonTextColorBtn: ColorManager.black,
                        borderSideColorBtn: ColorManager.gray1.withOpacity(0),
                      ),
                    ) :
                    CircularProgressIndicator(
                      color: ColorManager.black, //<-- SEE HERE
                    );
                  })
                );
              },
              onChanged: (val) {
                logic.homeLogic.search(val);
              },
            ),
            const SizedBox(height: AppSize.s24),
            GridViewPage(
                childAspectRatio: 1.45,
                visibleEdit: true,
                visibleBtnSms: false,
                visibleBtn: true,
                items: logic.homeLogic.groupList,
                activeCheckBox: false,
                isCheckedAll: false,
                onTapCheckBoxAll: false,
                textFieldController: logic.homeLogic.txtSearchUser,
                onChanged: (val) {
                  if (logic.navbarLogic.selected.value == 0) {
                    logic.homeLogic.searchUser(val);
                  } else {
                    logic.addMemberLogic.searchUser(val);
                  }
                },
                childBtnDelete: Obx(() {
                  return Visibility(
                    visible: logic.visibleDeleteUserGroup.value,
                    child: WhiteBtn(
                      onPress: () {
                        logic.dialogDeleteUserGroup(context);
                      },
                      text: 'حذف کاربران',
                      buttonTextColorWhite: ColorManager.red,
                    ),
                  );
                }),
                child: logic.navbarLogic.selected.value != 0 ?
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: logic.homeLogic.isCheckedList.length,
                      itemBuilder: (context, index) {
                        return ItemListUser(
                          activeCheckBox: false,
                          itemsActive: false,
                          activeEditItem: false,
                          itemsUserName: logic.addMemberLogic.listUser[index]
                              .name,
                          itemsUserFamily: logic.addMemberLogic.listUser[index]
                              .family,
                          itemsUserPhone: logic.addMemberLogic.listUser[index]
                              .phone,
                          itemsIndex: index,
                        );
                      },
                    );
                  }),
                ) :
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: logic.homeLogic.isCheckedList.length,
                      itemBuilder: (context, index) {
                        final isSelected = false.obs;
                        Model item = logic.homeLogic.isCheckedList[index];
                        isSelected.value = item.user.id != item.user.id;
                        return Obx(() {
                          return ItemListUser(
                            activeCheckBox: true,
                            itemsActive: isSelected.value,
                            activeEditItem: false,
                            itemsUserName: logic.homeLogic.isCheckedList[index].user.name,
                            itemsUserFamily: logic.homeLogic.isCheckedList[index].user.family,
                            itemsUserPhone: logic.homeLogic.isCheckedList[index].user.phone,
                            itemsIndex: index,
                            onTap: () {
                              // idTradingList.value = item.id;
                              isSelected.value = !isSelected.value;
                              if (isSelected.value == true) {
                                logic.idUser.add(item.user.id);
                              } else {
                                logic.idUser.remove(item.user.id);
                              }
                              logic.idUser.isEmpty == true ? logic.visibleDeleteUserGroup.value = false : logic.visibleDeleteUserGroup.value = true;
                            },
                          );
                        });
                      },
                    );
                  }),
                )
            ),
            const SizedBox(height: AppSize.s24),
          ],
        )
    );
  }
}
