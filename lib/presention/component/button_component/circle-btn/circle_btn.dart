// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../org-btn/wid_button.dart';

class CircleButton extends WidgetButtonCircle {
  final onPress;
  final icons;
  final Color colors;
  final double bordersSide;
  final Color borderSideColors;
  final Color buttonColorCircle;
  final double widthCircle;
  final double heightCircle;
  final double appSize;

  const CircleButton({super.key,required this.appSize,required this.widthCircle, required this.heightCircle, required this.buttonColorCircle, required this.onPress, required this.icons, required this.colors , required this.bordersSide , required this.borderSideColors})
      : super(
    // width: widthCircle,
    // height: heightCircle,
    buttonColor: buttonColorCircle,
    buttonOnPressed: onPress,
    icon: icons,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthCircle,
      height: heightCircle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(appSize),
        border: Border.all(color: borderSideColors,width: bordersSide),
      ),
      child: WidgetButtonCircle(
        buttonOnPressed: buttonOnPressed,
        buttonColor: buttonColor,
        icon: icon,
      ),
    );
  }
}

