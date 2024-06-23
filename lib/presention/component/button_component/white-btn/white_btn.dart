// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';
import '../org-btn/wid_button.dart';

class WhiteBtn extends WidgetButton {
  final onPress;
  final String text;
  final Color buttonTextColorWhite;
  WhiteBtn({super.key, required this.onPress, required this.text,required this.buttonTextColorWhite})
      : super(

    height: AppSize.s24,
    borderRadius:AppSize.s8,
    fontSize: AppSize.s12,
    buttonColor: ColorManager.white.withOpacity(0),
   // buttonMargin:const EdgeInsets.only(left: AppMargin.m16, right: AppMargin.m16,bottom:AppMargin.m16 ),
    buttonOnPressed: onPress,
    buttonText: text,
    buttonTextColor: buttonTextColorWhite,
    borderSideColor: ColorManager.white,
  );
}
