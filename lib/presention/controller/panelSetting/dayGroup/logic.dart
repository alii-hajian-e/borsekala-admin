import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../component/button_component/btn/_btn.dart';
import '../../../component/button_component/circle-btn/circle_btn.dart';
import '../../panelSms/home/logic.dart';

class DayGroupLogic extends GetxController {

  final homeLogic = Get.put(HomeLogic());
  final AppApiPanel apiServicePanel = AppApiPanel();
  final numbers = 0.obs;

  void showDayChangeDialog(
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
                Text('تغییر روز', style: textStyle),
                const SizedBox(height: AppSize.s8),
                Text('شما می‌توانید روز جست‌وجو عرضه را تغییر دهید.',
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
                          if(numbers.value <= 30){
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
                        '${numbers.value.toString()} روز بعد ',
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
                          if (numbers.value != 0) {
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
                          updateTimeRequest(context: context,id: id);
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

  void updateTimeRequest({context,id}) async{
    updateTime(context: context, id: id, data: {
      'cron_job_future_days': numbers.value,
    });
  }
  Future<void> updateTime ({Map<String, dynamic>? data, context,id}) async{
    try{
      final response = await apiServicePanel.patch(url: '${AppUrl.panelRoom}$id/',data: data ,
          options: Options(headers:{'Content-Type': 'application/x-www-form-urlencoded'}));
      if(response.statusCode == 200){
        GoRouter.of(context).pop();
        homeLogic.getPanelRoom(context);
      }
    } on DioException catch (e){
      Alert(txt: 'اطلاعات وارد شده اشتباه است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
}