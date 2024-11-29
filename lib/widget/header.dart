import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String txtHeader;

  const Header({super.key,required this.txtHeader});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(txtHeader,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s32)),
        const SizedBox(height: AppSize.s24),
        Divider(height: AppSize.s2,color: ColorManager.black.withOpacity(0.3),endIndent: AppSize.s48),
      ],
    );
  }
}
