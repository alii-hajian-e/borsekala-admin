import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/header_component/header_component.dart';
import '../../component/item_list_user/item_list_user.dart';
import '../../component/list_user/listUser.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
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
                context,
                'اضافه کردن کاربر',
                'ثبت',
                'انصراف',
              );
            },
            onChanged: (val) {
              logic.searchUser(val);
            },
          ),
          const SizedBox(height: AppSize.s24),
          Expanded(
            child: ListViewUser(
              activeCheckBox: false,
              isCheckedAll: false,
              onTapCheckBoxAll: (){},
              childBtnDelete: Container(),
              child: Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: logic.listUser.length,
                    itemBuilder: (context, index) {
                      return ItemListUser(
                        activeCheckBox: false,
                        itemsActive: true,
                        activeEditItem: true,
                        itemsUserName: logic.listUser[index].name,
                        itemsUserFamily: logic.listUser[index].family,
                        itemsUserPhone: logic.listUser[index].phone,
                        itemsIndex: index,
                        onPressDeleteItem: (){
                          logic.dialogDeleteItem(context,index);
                        },
                        onPressEditeItem: (){
                          logic.dialogEditeUser(
                            phone: logic.listUser[index].phone,
                            name: logic.listUser[index].name,
                            family: logic.listUser[index].family,
                            id: logic.listUser[index].id,
                            context: context,
                            hintTextFamily: logic.listUser[index].family,
                            hintTextName: logic.listUser[index].name,
                            hintTextPhone: logic.listUser[index].phone,
                            txtAlert: 'ویرایش کاربر',
                            txtBtn1: 'ذخیره',
                            txtBtn: 'انصراف',
                          );
                        },
                      );
                    },
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
