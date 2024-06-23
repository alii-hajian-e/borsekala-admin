// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';

class WidgetDialogList extends StatelessWidget {

  final column;
  final width;
  final height;
  const WidgetDialogList({
    super.key, required this.column,required this.width,required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      shadowColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppSize.s16),
        ),
      ),
      child: Container(
        width: width,
          height: height,
          margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m16,
            vertical: AppMargin.m16,
          ),
          child: column
      ),
    );
  }
}
