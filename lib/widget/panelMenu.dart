// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../presention/component/button_component/avatar-btn/avatar_btn.dart';
import '../presention/component/dialog_component/dialog_action/dialod_action.dart';
import '../presention/component/item_drow_component/iteme-drow-component.dart';
import '../presention/controller/login/logic.dart';
import '../presention/resources/assets_manager.dart';
import '../presention/resources/color_manager.dart';
import '../presention/resources/shared_manager.dart';
import '../presention/resources/value_manager.dart';

class PanelMenu extends StatelessWidget {
  final dynamic widgetUi;

  const PanelMenu({super.key, required this.widgetUi});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(AppSize.s16)),
      child: Drawer(
        width: MediaQuery
            .of(context).size.width / 5,
        backgroundColor: ColorManager.gray.withValues(alpha: 0.1),
        shape: Border.all(color: ColorManager.gray1, width: AppSize.s2),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s32),
                AvatarBtn(
                  nameKargozari: 'کارگزاری',
                  imageAvatar: 'data:image/jpeg;base64,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',
                  widthBorderAvatar: AppSize.s0,
                  buttonColorAvatar: ColorManager.black.withValues(alpha: 0.0),
                  borderRadiusAvatar: AppSize.s16,
                  borderSideColorAvatar: ColorManager.gray.withValues(alpha: 0.0),
                  heightAvatarButtonAvatar: AppSize.s80,
                  widthAvatarButtonAvatar: AppSize.s80,
                ),
                const SizedBox(height: AppSize.s72),
                // add ui
                widgetUi,
                Expanded(child: Container()),
                const SizedBox(height: AppSize.s8),
                DrawerNavigationItem(
                  colorTxt: ColorManager.red,
                  iconData: SvgPicture.asset(fit: BoxFit.scaleDown,
                      ImageAssets.exit,
                      width: AppSize.s24,
                      height: AppSize.s24),
                  title: 'خروج از حساب',
                  onTap: () {
                    dialogEducation(context);
                    // GoRouter.of(context).go('/landingPage');
                    // Get.back();
                  },
                  selected: false,
                ),
                const SizedBox(height: AppSize.s32),
              ],
            )
        ),
      ),
    );
  }
  void dialogEducation(context){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.exit,width: AppSize.s24,height: AppSize.s24),
          txtAlert: 'آیا از خروج از حساب مطمئن هستید؟',
          txtBtn1: 'انصراف',
          txtBtn: 'خروج',
          onPress: () {
            MyPreferences.clearDataSaving();
            final loginLogic = Get.put(LoginLogic());
            loginLogic.onInit();
            // GoRouter.of(context).go('/');
            GoRouter.of(context).pushReplacement('/');
          },
          onPress1: (){
            // Get.back();
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }

}

