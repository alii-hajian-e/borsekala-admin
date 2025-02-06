// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../button_component/btn/_btn.dart';
import '../../button_component/circle-btn/circle_btn.dart';


class WidgetDialogAction extends StatelessWidget {

  final String txtAlert;
  final String txtBtn;
  final String txtBtn1;
  final dynamic onPress;
  final dynamic onPress1;
  final dynamic icons;

  const WidgetDialogAction({
    super.key, required this.txtAlert, required this.txtBtn, required this.txtBtn1, this.onPress, this.onPress1,required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: ColorManager.white,
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(
      //     Radius.circular(AppSize.s16),
      //   ),
      // ),
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p24),
        width: AppSize.s380,
        height: AppSize.s280,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleButton(
              appSize: AppSize.s72,
              widthCircle: AppSize.s100,
              heightCircle: AppSize.s100,
              buttonColorCircle: ColorManager.gray1.withOpacity(0.6),
              onPress: null,
              icons: icons,
              colors: ColorManager.gray1.withOpacity(0.6),
              bordersSide: AppSize.s2,
              borderSideColors: ColorManager.gray1.withOpacity(0.6),
            ),
            const SizedBox(height: AppSize.s24),
            Text(txtAlert,style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14)),
            const SizedBox(height: AppSize.s24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Btn(
                    buttonColorBtn: ColorManager.red,
                    onPress: onPress,
                    text: txtBtn,
                    heightBtn: AppSize.s48,
                    borderRadiusBtn: AppSize.s8,
                    buttonTextColorBtn: ColorManager.white,
                    borderSideColorBtn: ColorManager.red,
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: Btn(
                    buttonColorBtn: ColorManager.gray1,
                    onPress: onPress1,
                    text: txtBtn1,
                    heightBtn: AppSize.s48,
                    borderRadiusBtn: AppSize.s8,
                    buttonTextColorBtn: ColorManager.black,
                    borderSideColorBtn: ColorManager.gray1,
                  ),
                ),
              ],
            )
          ],

        ),
      ),
    );
  }
}
