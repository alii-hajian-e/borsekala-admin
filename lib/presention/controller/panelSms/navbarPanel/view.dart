import 'package:bors_web_admin_sms/widget/panelMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../component/button_component/circle-btn/circle_btn.dart';
import '../../../component/input_component/defult/defulttextfield.dart';
import '../../../component/item_drow_component/iteme-drow-component.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../addgroupe/view.dart';
import '../addmember/view.dart';
import '../home/view.dart';
import 'logic.dart';


class NavbarPanelPage extends StatelessWidget {
  NavbarPanelPage({super.key});

  final logic = Get.put(NavbarPanelLogic());
  final screen = [
    HomePage(),
    AddMemberPage(),
    AddGroupPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: logic.scaffoldPanelKey,
      backgroundColor: ColorManager.white,
      endDrawer: ClipRRect(
        borderRadius: const BorderRadius.horizontal(right: Radius.circular(AppSize.s16)),
        child: Drawer(
          width: MediaQuery.of(context).size.width / 3,
          shape: Border.all(color: ColorManager.gray1, width: AppSize.s2),
          child: Container(
            color: ColorManager.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: ()=>
                            Navigator.of(context).pop(),
                        child: Row(
                          children: [
                            Container(
                              width: AppSize.s32,
                              height: AppSize.s32,
                              decoration: BoxDecoration(
                                color: ColorManager.gray,
                                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                              ),
                              child: CircleButton(
                                appSize: AppSize.s8,
                                widthCircle: AppSize.s32,
                                heightCircle: AppSize.s32,
                                buttonColorCircle: ColorManager.gray.withOpacity(0.0),
                                onPress: null,
                                icons: const Icon(Icons.clear,size: AppSize.s18),
                                colors: ColorManager.gray,
                                bordersSide: AppSize.s2,
                                borderSideColors: ColorManager.gray,
                              ),
                            ),
                            const SizedBox(width: AppSize.s16),
                            Text(
                              'بستن',
                              style: getBoldStyle(
                                  color: ColorManager.black, fontSize: AppSize.s14),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'پشتیبانی',
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: AppSize.s18),
                      ),

                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal:AppMargin.m24),
                    decoration: BoxDecoration(
                      color: ColorManager.gray,
                      borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
                      border: Border.all(color: ColorManager.gray1, width: AppSize.s2),
                    ),
                    child: Obx(() {
                      return ListView.builder(
                        controller: logic.scrollController,
                        itemCount: logic.listChat.length,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime dateTime = DateTime.parse(logic.listChat[index].updatedAt.toString());
                          Jalali jalaliDate = Jalali.fromDateTime(dateTime);
                          return Align(
                            alignment: !logic.listChat[index].isAdminMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: AppSize.s180,
                              padding: const EdgeInsets.all(AppPadding.p8),
                              margin: const EdgeInsets.symmetric(vertical: AppMargin.m4, horizontal: AppMargin.m8),
                              decoration: BoxDecoration(
                                color: logic.listChat[index].isAdminMessage ? Colors.yellow : Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(AppSize.s8),
                              ),
                              child: Column(
                                mainAxisAlignment: logic.listChat[index].isAdminMessage
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: logic.listChat[index].isAdminMessage
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    !logic.listChat[index].isAdminMessage ? 'شما' : 'پشتیبانی',
                                    style: getMediumStyle(
                                        color: ColorManager.black, fontSize: AppSize.s10),
                                  ),
                                  const SizedBox(height: AppSize.s8),
                                  Text(
                                    logic.listChat[index].content,
                                    style: getBoldStyle(
                                        color: ColorManager.black, fontSize: AppSize.s14),
                                  ),
                                  const SizedBox(height: AppSize.s8),
                                  Align(
                                    alignment: logic.listChat[index].isAdminMessage
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      '${jalaliDate.minute.toString()} : ${jalaliDate.hour.toString()}',
                                      style: getMediumStyle(
                                          color: ColorManager.black, fontSize: AppSize.s10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSize.s48,
                        height: AppSize.s48,
                        decoration: BoxDecoration(
                          color: ColorManager.yellow,
                          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                        ),
                        child: CircleButton(
                          appSize: AppSize.s8,
                          widthCircle: AppSize.s16,
                          heightCircle: AppSize.s16,
                          buttonColorCircle: ColorManager.yellow.withOpacity(0.0),
                          onPress: (){
                            logic.scrollController.animateTo(
                              logic.scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 2000),
                              curve: Curves.easeOut,
                            );
                            logic.sentRequest(context);
                          },
                          icons: SvgPicture.asset(ImageAssets.send,fit: BoxFit.scaleDown,width: 16,height: 16,),
                          colors: ColorManager.yellow,
                          bordersSide: AppSize.s2,
                          borderSideColors: ColorManager.yellow,
                        ),
                      ),
                      const SizedBox(width: AppSize.s16),
                      Expanded(
                        child: DefaultTextField(
                          obscureText: false,
                          textFieldColor: ColorManager.gray,
                          textInputType: TextInputType.text,
                          borderSideWidth: AppSize.s2,
                          borderSideColor: ColorManager.gray,
                          hintStyle: getMediumStyle(color: ColorManager.black.withOpacity(0.6), fontSize: AppSize.s14),
                          hintText: 'چه کمکی از ما بر می آید؟',
                          textFieldActive: false,
                          textFieldController: logic.txtChat,
                          textAlign: TextAlign.right,

                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                        ImageAssets.people,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: "لیست کاربران",
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
                        ImageAssets.category_2,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: "دسته بندی ها",
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
                const SizedBox(height: AppSize.s8),
                Obx(() {
                  return DrawerNavigationItem(
                    colorTxt: ColorManager.black,
                    iconData: SvgPicture.asset(fit: BoxFit.scaleDown,
                        ImageAssets.property,
                        width: AppSize.s24,
                        height: AppSize.s24),
                    title: "پشتیبانی",
                    onTap: () {
                      logic.selectedIndex.value = false;
                      logic.selectedIndex1.value = false;
                      logic.selectedIndex2.value = false;
                      logic.selectedIndex3.value = true;
                      logic.listChatUser(context);
                      logic.scaffoldPanelKey.currentState?.openEndDrawer();
                    },
                    selected: logic.selectedIndex3.value,
                  );
                }),
                const SizedBox(height: AppSize.s8),
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

