import 'package:flutter/material.dart';

import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

class Tag extends StatelessWidget {

  final Color colorText;
  final Color colorBackground;
  final double fontSize;
  final String txt;

  const Tag({
    super.key,
    required this.colorText,
    required this.fontSize,
    required this.colorBackground, required this.txt,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16,vertical: AppPadding.p4),
        child: Align(
          alignment: Alignment.center,
          child: Text(txt ,style: getBoldStyle(color: colorText,fontSize: fontSize),),
        ),
      ),
    );
  }
}
