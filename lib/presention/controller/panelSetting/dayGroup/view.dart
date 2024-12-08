import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dataurl/data/model/getdatagroupapi.dart';
import '../../../../widget/header.dart';
import '../../../component/item_list_time_group/item_list_time.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../navbarSetting/logic.dart';
import 'logic.dart';

class DayGroupPage extends StatelessWidget {
  DayGroupPage({super.key});

  final logic = Get.put(DayGroupLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ColorManager.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s56, vertical: AppPadding.p32),
            child: Column(
              children: [
                Obx(() {
                  final navbarSettingLogic = Get.put(NavbarSettingLogic());
                  return Header(
                      txtHeader: '${navbarSettingLogic.nameAdmin
                          .value} ${navbarSettingLogic.familyAdmin.value}');
                }),
                const SizedBox(height: AppSize.s24),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: logic.homeLogic.groupList.length,
                      itemBuilder: (context, index) {
                        final group = logic.homeLogic.groupList[index];
                        final tradingHall = GetDateGroupApi().findTradingHallById(group.hallId);
                        return GroupListItem(
                          active: false,
                          index: index,
                          tradingHall: tradingHall,
                          group: group,
                          onPressUpdate: () {
                            logic.numbers.value = group.cronJobFutureDays!;
                            logic.showDayChangeDialog(context: context, id: logic.homeLogic.groupList[index].id);
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          )
      ),
    );
  }
}
