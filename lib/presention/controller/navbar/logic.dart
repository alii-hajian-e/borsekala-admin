
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/data/model/chat-model.dart';
import '../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../dataurl/data/network/service/api_service.dart';
import '../../component/alert/alert.dart';
import '../../component/dialog_component/dialog_action/dialod_action.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';
import '../../resources/value_manager.dart';

class NavbarLogic extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final selected = 0.obs;
  final selectedIndex = true.obs;
  final selectedIndex1 = false.obs;
  final selectedIndex2 = false.obs;
  final selectedIndex3 = false.obs;
  final txtChat = TextEditingController();
  final AppApiPanel apiServicePanel = AppApiPanel();
  ScrollController scrollController = ScrollController();

  final listChat = <Message>[].obs;


  void changeIndex(int index){
    selected.value = index;
  }
  void dialogEducation(context){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.exit,width: AppSize.s24,height: AppSize.s24),
          txtAlert: 'آیا از خروج از حساب مطمئن هستید؟',
          txtBtn1: 'انصراف',
          txtBtn: 'خروج',
          onPress: () {
            MyPreferences.clearDataSaving();
            // GoRouter.of(context).go('/');
            GoRouter.of(context).pushReplacement('/');
          },
          onPress1: (){
            // Get.back();
            GoRouter.of(context).pop();
          },
        );
      },
    );
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
