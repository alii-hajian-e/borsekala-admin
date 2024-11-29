import 'package:bors_web_admin_sms/presention/controller/panelSetting/admin/view.dart';
import 'package:bors_web_admin_sms/presention/controller/panelSetting/homeSetting/view.dart';
import 'package:bors_web_admin_sms/widget/panelMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../component/item_drow_component/iteme-drow-component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../transaction/view.dart';
import 'logic.dart';


class NavbarSettingPage extends StatelessWidget {
  NavbarSettingPage({super.key});

  final logic = Get.put(NavbarSettingLogic());
  final screen = [
    HomeSettingPage(),
    TransactionPage(),
    AdminPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: logic.scaffoldSettingKey,
      backgroundColor: ColorManager.white,
      body: Row(
        children: [
          PanelMenu(
            widgetUi: Column(
              children: [
                Obx(() {
                  return DrawerNavigationItem(
                    colorTxt: ColorManager.black,
                    iconData: SvgPicture.asset(fit: BoxFit.scaleDown,
                        ImageAssets.home_2,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: 'صفحه اصلی',
                    onTap: () {
                      logic.changeIndex(0);
                      logic.selectedIndex.value = true;
                      logic.selectedIndex1.value = false;
                      logic.selectedIndex2.value = false;
                      logic.selectedIndex3.value = false;
                    },
                    selected: logic.selectedIndex.value,
                  );
                }),
                const SizedBox(height: AppSize.s8),
                Obx(() {
                  return DrawerNavigationItem(
                    colorTxt: ColorManager.black,
                    iconData: SvgPicture.asset(fit: BoxFit.scaleDown,
                        ImageAssets.paper,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: "صورت حساب",
                    onTap: () {
                      logic.changeIndex(1);
                      logic.selectedIndex.value = false;
                      logic.selectedIndex1.value = true;
                      logic.selectedIndex2.value = false;
                      logic.selectedIndex3.value = false;
                    },
                    selected: logic.selectedIndex1.value,
                  );
                }),
                const SizedBox(height: AppSize.s8),
                Obx(() {
                  return DrawerNavigationItem(
                    colorTxt: ColorManager.black,
                    iconData: SvgPicture.asset(fit: BoxFit.scaleDown,
                        ImageAssets.password,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: "مدیران",
                    onTap: () {
                      logic.changeIndex(2);
                      logic.selectedIndex.value = false;
                      logic.selectedIndex1.value = false;
                      logic.selectedIndex2.value = true;
                      logic.selectedIndex3.value = false;
                    },
                    selected: logic.selectedIndex2.value,
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Obx(() =>
                IndexedStack(
                  index: logic.selected.value,
                  children: screen,
                ),
            ),
          ),
        ],
      ),
    );
  }
}

