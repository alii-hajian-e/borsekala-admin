import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../component/button_component/btn/_btn.dart';
import '../../../component/button_component/circle-btn/circle_btn.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../panelSms/home/logic.dart';

class TimeGroupLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());

  final AppApiPanel apiServicePanel = AppApiPanel();
  final numbers = 0.obs;

  void showSMSTImeChangeDialog(
      {required BuildContext context, required id}) {
    showDialog(
      context: context,
      builder: (context) {
        final textStyle = getMediumStyle(
            color: ColorManager.black, fontSize: AppSize.s16);
        final subTextStyle = getMediumStyle(
          color: ColorManager.black.withOpacity(0.5),
          fontSize: AppSize.s14,
        );
        return Dialog(
          child: Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 3,
            padding: const EdgeInsets.all(AppSize.s24),
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(AppSize.s16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('زمان ارسال پیامک', style: textStyle),
                const SizedBox(height: AppSize.s8),
                Text('شما می‌توانید ساعت ارسال پیامک را تغییر دهید.',
                    style: subTextStyle),
                const SizedBox(height: AppSize.s24),
                Obx(() {
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
                        onPress: () {
                          if(numbers.value <= 23){
                            numbers.value++;
                          }
                        },
                        icons: Icon(Icons.keyboard_arrow_right,
                          color: ColorManager.white,),
                        bordersSide: AppSize.s0,
                        borderSideColors: ColorManager.white,
                      ),
                      const SizedBox(width: AppSize.s16),
                      Text(
                        '00 : ${numbers.value.toString()}',
                        style: getMediumStyle(color: ColorManager.black,
                            fontSize: AppSize.s14),
                      ),
                      const SizedBox(width: AppSize.s16),
                      CircleButton(
                        colors: ColorManager.black,
                        appSize: AppSize.s8,
                        widthCircle: AppSize.s40,
                        heightCircle: AppSize.s40,
                        buttonColorCircle: ColorManager.black,
                        onPress: () {
                          if (numbers.value != 15) {
                            numbers.value--;
                          }
                        },
                        icons: Icon(Icons.keyboard_arrow_left,
                          color: ColorManager.white,),
                        bordersSide: AppSize.s0,
                        borderSideColors: ColorManager.white,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: AppSize.s24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Btn(
                        buttonColorBtn: ColorManager.yellow,
                        onPress: () {
                          updateTimeSMSRequest(context: context,id: id);
                        },
                        text: 'دخیره',
                        heightBtn: AppSize.s48,
                        borderRadiusBtn: AppSize.s8,
                        buttonTextColorBtn: ColorManager.black,
                        borderSideColorBtn: ColorManager.yellow,
                      ),
                    ),
                    const SizedBox(width: AppSize.s16),
                    Expanded(
                      child: Btn(
                        buttonColorBtn: ColorManager.gray1,
                        onPress: () => GoRouter.of(context).pop(),
                        text: 'انطراف',
                        heightBtn: AppSize.s48,
                        borderRadiusBtn: AppSize.s8,
                        buttonTextColorBtn: ColorManager.black,
                        borderSideColorBtn: ColorManager.gray1,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void updateTimeSMSRequest({context,id}) async{
    updateTimeSMS(context: context, id: id, data: {
      'cron_job_time': numbers.value,
    });
  }
  Future<void> updateTimeSMS ({Map<String, dynamic>? data, context,id}) async{
    try{
      final response = await apiServicePanel.patch(url: '${AppUrl.panelRoom}$id/',data: data ,
          options: Options(headers:{'Content-Type': 'application/x-www-form-urlencoded'}));
      if(response.statusCode == 200){
        homeLogic.getPanelRoom(context);
        GoRouter.of(context).pop();
      }
    } on DioException catch (e){
      Alert(txt: 'اطلاعات وارد شده اشتباه است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
}
