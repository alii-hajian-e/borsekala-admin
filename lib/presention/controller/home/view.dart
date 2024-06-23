
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/gridview_component/gridview.dart';
import '../../component/header_component/header_component.dart';
import '../../component/item_list_user/item_list_user.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final logic = Get.put(HomeLogic());

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
          Text('گروه ها',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s32)),
          const SizedBox(height: AppSize.s24),
          HeaderBar(
            visible: false,
            textFieldController: logic.txtSearch,
            icon: Icons.person_outline,
            nameBtn: 'افزودن کاربر',
            onPress: (){},
            onChanged: (val) {
              logic.search(val);
            },
          ),
          const SizedBox(height: AppSize.s24),
          GridViewPage(
            childAspectRatio: 1.45,
            visibleBtn: false,
            visibleBtnSms : true,
            visibleEdit: false,
            items: logic.groupList,
            activeCheckBox: false,
            isCheckedAll: false,
            onTapCheckBoxAll: false,
            textFieldController: logic.txtSearchUser,
            onChanged: (val) {
              logic.searchUser(val);
            },
            childBtnDelete: Container(),
            child: Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: logic.isCheckedList.length,
                  itemBuilder: (context, index) {
                    return ItemListUser(
                      activeCheckBox: false,
                      itemsActive: false,
                      activeEditItem: false,
                      itemsUserName: logic.isCheckedList[index].user.name,
                      itemsUserFamily: logic.isCheckedList[index].user.family,
                      itemsUserPhone: logic.isCheckedList[index].user.phone,
                      itemsIndex: index,
                    );
                  },
                );
              }),
            ),
          ),
          const SizedBox(height: AppSize.s24),
        ],
      )
    );
  }
}
