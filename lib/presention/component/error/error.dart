// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';

class SnackBarWid {
  final text;
  final color;
  final icon;
  final title;

  SnackBarWid(this.text,this.title, this.color, this.icon);

  SnackbarController build() {
    return Get.showSnackbar(GetSnackBar(
      title: title,
      backgroundColor: color,
      margin: const EdgeInsets.all(AppSize.s24),
      borderRadius: 16,
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(icon,color: ColorManager.white),
      message: text,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      duration: const Duration(seconds: 4),
    ));
  }
}