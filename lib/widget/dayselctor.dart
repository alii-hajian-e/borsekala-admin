import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:flutter/material.dart';

import '../presention/component/button_component/circle-btn/circle_btn.dart';
import '../presention/resources/color_manager.dart';
import '../presention/resources/value_manager.dart';

class DaySelector extends StatelessWidget {
  final String numbers;
  final VoidCallback onPressPlus;
  final VoidCallback onPressNegative;

  const DaySelector({
    super.key,
    required this.numbers,
    required this.onPressPlus,
    required this.onPressNegative,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        CircleButton(
          colors: ColorManager.black,
          appSize: AppSize.s8,
          widthCircle: AppSize.s40,
          heightCircle: AppSize.s40,
          buttonColorCircle: ColorManager.black,
          onPress: onPressPlus,
          icons: Icon(
            Icons.add,
            color: ColorManager.white,
          ),
          bordersSide: AppSize.s0,
          borderSideColors: ColorManager.white,
        ),
        const SizedBox(width: AppSize.s16),
        SizedBox(
          width: AppSize.s64,
          child: Text(
            numbers,
            textAlign: TextAlign.center,
            style: getMediumStyle(
                color: ColorManager.black,
                fontSize: AppSize.s14
            ),
          ),
        ),
        const SizedBox(width: AppSize.s16),
        CircleButton(
          colors: ColorManager.black,
          appSize: AppSize.s8,
          widthCircle: AppSize.s40,
          heightCircle: AppSize.s40,
          buttonColorCircle: ColorManager.black,
          onPress: onPressNegative,
          icons: Icon(
            Icons.remove,
            color: ColorManager.white,
          ),
          bordersSide: AppSize.s0,
          borderSideColors: ColorManager.white,
        ),

      ],
    );
  }
}
