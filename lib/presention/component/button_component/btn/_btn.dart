// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/value_manager.dart';
import '../org-btn/wid_button.dart';

class Btn extends WidgetButton {
  final onPress;
  final String text;
  final double heightBtn;
  final double borderRadiusBtn;
  final Color buttonColorBtn;
  final Color buttonTextColorBtn;
  final Color borderSideColorBtn;

  const Btn({super.key,
    required this.buttonColorBtn,
    required this.onPress,
    required this.text,
    required this.heightBtn,
    required this.borderRadiusBtn,
    required this.buttonTextColorBtn,
    required this.borderSideColorBtn,
  }) : super(

    height: heightBtn,
    borderRadius: borderRadiusBtn,
    fontSize: AppSize.s14,
    buttonColor: buttonColorBtn,
    buttonOnPressed: onPress,
    buttonText: text,
    buttonTextColor: buttonTextColorBtn,
    borderSideColor: borderSideColorBtn,
  );
}
