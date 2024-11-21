
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/data/model/chat-model.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/shared_manager.dart';
import '../../login/logic.dart';


class NavbarPanelLogic extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldPanelKey = GlobalKey<ScaffoldState>();
  final selected = 0.obs;
  final selectedIndex = true.obs;
  final selectedIndex1 = false.obs;
  final selectedIndex2 = false.obs;
  final selectedIndex3 = false.obs;
  final txtChat = TextEditingController();
  final AppApiPanel apiServicePanel = AppApiPanel();
  ScrollController scrollController = ScrollController();
  final loginLogic = Get.put(LoginLogic());

  final listChat = <Message>[].obs;


  void changeIndex(int index){
    selected.value = index;
  }

  Future<void> listChatUser (context) async{
    try{
      final response = await apiServicePanel.get(AppUrl.chatList, Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        listChat.clear();
        listChat.value = response.data['results'].map<Message>((json) => Message.fromJson(json)).toList();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }catch(e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void sentRequest(context){
    if(txtChat.text.isNotEmpty){
      send(context,data: {'content': txtChat.text.toString()});
    } else {
      Alert(txt: 'خطا در اطلاعات وارد شده', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> send (context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanel.post(url: AppUrl.chatList ,data: data , options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}"}));
      if(response.statusCode == 201){
        txtChat.clear();
        listChatUser(context);
      }
    }catch(e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }


}
