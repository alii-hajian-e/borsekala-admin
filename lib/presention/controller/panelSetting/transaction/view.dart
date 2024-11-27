import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../widget/header.dart';
import '../../../resources/assets_manager.dart';
import 'logic.dart';

class TransactionPage extends StatelessWidget {
  TransactionPage({super.key});

  final logic = Get.put(TransactionLogic());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSize.s56, vertical: AppPadding.p32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Header(txtHeader: '${logic.homeSettingLogic.adminList.first.name  ?? ''} ${logic.homeSettingLogic.adminList.first.family  ?? ''}'),
              const SizedBox(height: AppSize.s40),
              SvgPicture.asset(fit: BoxFit.scaleDown,
                  ImageAssets.engin,
                  width: AppSize.s300,
                  height: AppSize.s300
              ),
              const SizedBox(height: AppSize.s32),
              Text('در حال بروز رسانی هستیم',style: getBoldStyle(color: ColorManager.black.withOpacity(0.7),fontSize: AppSize.s24),)
            ],
          ),
        )
      ),
    );
  }
}
