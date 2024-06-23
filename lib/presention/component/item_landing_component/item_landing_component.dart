// ignore_for_file: must_be_immutable


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';

class ItemLanding extends StatelessWidget {

  final dynamic onTap;
  final String img;
  final String txt;
  const ItemLanding({super.key, this.onTap, required this.img, required this.txt});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: AppSize.s200,
        height: AppSize.s200,
        decoration: BoxDecoration(
            color: ColorManager.gray,
            borderRadius: BorderRadius.circular(AppSize.s16),
            border: Border.all(color: ColorManager.gray1,width: AppSize.s2)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(fit: BoxFit.scaleDown,
                img,
                width: AppSize.s80,
                height: AppSize.s80),
            const SizedBox(height: AppSize.s16),
            Text(txt,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s16))
          ],
        ),
      ),
    );
  }
}
