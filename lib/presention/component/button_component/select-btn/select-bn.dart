// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:flutter/material.dart';

import '../org-btn/wid_button.dart';

class SelectBtn extends WidgetButtonSelect {
  final onPress;
  final String text;
  final Color borderColor;
  final Color colorTextSelect;
  final double radius;
  final double appSizeBtn;
  final double heightBtn;
  final double appPaddingSelect;
  final dynamic iconSelect;
  final Color backgroundColorSelect;
  final MainAxisAlignment mainAxisAlignmentSelect;
  final bool visibleSelect;

  const SelectBtn({super.key,required this.appSizeBtn,required this.appPaddingSelect,required this.mainAxisAlignmentSelect,required this.visibleSelect, required this.iconSelect,required this.onPress, required this.text, required this.borderColor, required this.radius, required this.heightBtn, required this.colorTextSelect, required this.backgroundColorSelect}) : super(
    appSize: appSizeBtn,
    buttonOnPressed: onPress,
    colorText: colorTextSelect,
    height: heightBtn,
    icon: iconSelect,
    txt: text,
    borderSideColor: borderColor,
    borderRadius: radius,
    backgroundColor: backgroundColorSelect,
    mainAxisAlignment: mainAxisAlignmentSelect,
    visible: visibleSelect,
    appPadding: appPaddingSelect,
  );
}