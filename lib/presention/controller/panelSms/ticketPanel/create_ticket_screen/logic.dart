import 'package:bors_web_admin_sms/dataurl/constants/app_url.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../dataurl/data/model/ticket-model.dart';
import '../../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../../component/alert/alert.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/shared_manager.dart';

class CreateTicketScreenLogic extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final category = <TicketCategory>[].obs;
  final selectedDepartment = 'Technical'.obs;
  final AppApiPanel apiServicePanel = AppApiPanel();


  Future<void> listCategory ({context}) async{
    try{
      final response = await apiServicePanel.get(AppUrl.category, Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        category.clear();
        category.value = response.data.map<TicketCategory>((json) => TicketCategory.fromJson(json)).toList();
      }
    }catch(e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
}
