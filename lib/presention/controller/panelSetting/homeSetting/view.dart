import 'package:bors_web_admin_sms/presention/component/list_user/listUser.dart';
import 'package:bors_web_admin_sms/presention/resources/assets_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:bors_web_admin_sms/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widget/card.dart';
import '../../../component/item_list_user/item_list_user.dart';
import 'logic.dart';

class HomeSettingPage extends StatelessWidget {
  HomeSettingPage({super.key});

  final logic = Get.put(HomeSettingLogic());

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
                Header(txtHeader: '${logic.adminList.first.name  ?? ''} ${logic.adminList.first.family  ?? ''}'),
                const SizedBox(height: AppSize.s24),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Wallet(
                //         image: ImageAssets.danger,
                //         widthImage: AppSize.s32,
                //         heightImage: AppSize.s32,
                //         txt: 'مصرف شارژ روزانه بر اساس پیامک های ارسال شده :',
                //         txtButton: '',
                //         price: '۲,۰۰۰,۰۰۰ تومان',
                //         onPress: () {},
                //         visibleBtn: false,
                //       ),
                //     ),
                //     const SizedBox(width: AppSize.s16),
                //     Expanded(
                //       child: Wallet(
                //         image: ImageAssets.wallet,
                //         widthImage: AppSize.s32,
                //         heightImage: AppSize.s32,
                //         txt: 'موجودی :',
                //         txtButton: 'شارژ کیف پول',
                //         price: '۲,۰۰۰,۰۰۰ تومان',
                //         onPress: () {},
                //         visibleBtn: true,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: AppSize.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return CardView(
                          image: ImageAssets.password,
                          txtCount: logic.adminList.length.toString(),
                          txtTitle: 'تعداد ادمین',
                          widthImage: AppSize.s32,
                          heightImage: AppSize.s32,
                        );
                      }),
                    ),
                    const SizedBox(width: AppSize.s16),
                    const Expanded(
                      child: CardView(
                        image: ImageAssets.paper,
                        txtCount: '0',
                        txtTitle: 'تعداد تراکنش ها',
                        widthImage: AppSize.s32,
                        heightImage: AppSize.s32,
                      ),
                    ),
                    const SizedBox(width: AppSize.s16),
                    Expanded(
                      child: Obx(() {
                        return CardView(
                          image: ImageAssets.people,
                          txtCount: logic.homeLogic.groupList.length.toString(),
                          txtTitle: 'تعداد گروه های ساخته شده',
                          widthImage: AppSize.s32,
                          heightImage: AppSize.s32,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s24),
                Expanded(
                  child: ListViewUser(
                    emailTxt: 'ایمیل',
                    activeCheckBox: false,
                    isCheckedAll: false,
                    onTapCheckBoxAll: () {},
                    childBtnDelete: Container(),
                    child: Expanded(
                      child: Obx(() {
                        return ListView.builder(
                          itemCount: logic.adminList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              return ItemListUser(
                                activeCheckBox: false,
                                itemsActive: false,
                                activeEditItem: false,
                                itemsUserName: logic.adminList[index].name  ?? '',
                                itemsUserFamily: logic.adminList[index].family  ?? '',
                                itemsUserPhone: logic.adminList[index].email  ?? '',
                                itemsIndex: index,
                                btnActive: true,
                                colorBtnActiveAdmin: !logic.adminList[index]
                                    .isActive
                                    ? ColorManager.red2
                                    : ColorManager.green,
                                colorTextBtnActiveAdmin: ColorManager.white,
                                txtActiveBtnAdmin: !logic.adminList[index]
                                    .isActive ?
                                'غیر فعال' :
                                'فعال',
                                onPressBtnActiveAdmin: () {
                                  logic.activeUserAdmin.value =
                                  !logic.activeUserAdmin.value;
                                  logic.updaterAdmin(
                                    active: logic.activeUserAdmin.value,
                                    context: context,
                                    family: logic.adminList[index].family,
                                    id: logic.adminList[index].id,
                                    name: logic.adminList[index].name,
                                    email: logic.adminList[index].email,
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
