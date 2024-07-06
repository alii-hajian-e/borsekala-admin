// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/item_landing_component/item_landing_component.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';
import 'logic.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final logic = Get.put(LandingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p80, vertical: AppPadding.p32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: AppSize.s56,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                              ImageAssets.splashLogo, height: AppSize.s80,
                              width: AppSize.s80,
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.gray1,
                          spreadRadius: 8,
                          blurRadius: 16,
                          offset: const Offset(
                              0, 0), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.s16)),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ImageAssets.headerImage),
                      ),
                    ),

                  ),
                  const SizedBox(height: AppSize.s24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p24),
                    child: Divider(
                        height: AppSize.s2, color: ColorManager.gray1),
                  ),
                  const SizedBox(height: AppSize.s24),

                  Obx(() {
                    return logic.loginLogic.loadingPanel.value == false ?
                    ItemLanding(
                        img: ImageAssets.sms, txt: 'پنل پیامکی', onTap: () {
                      logic.homeLogic.getPanelRoom(context);
                      logic.addMemberLogic.getUserList(context);
                      js.context.callMethod(
                          'open', ['http://webapp.ibrokers.ir/navbarPage']);
                      // GoRouter.of(context).go('/navbarPage');
                      // Get.toNamed(Routes.navbarPage);
                    }) :
                    SizedBox(
                      width: AppSize.s200,
                      height: AppSize.s200,
                      child: Center(
                        child: SizedBox(
                          width: AppSize.s40,
                          height: AppSize.s40,
                          child: CircularProgressIndicator(
                            color: ColorManager.black, //<-- SEE HERE
                          ),
                        ),
                      )
                    );
                  })

                ],
              ),
            )
        )
    );
  }
}
