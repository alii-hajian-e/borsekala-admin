
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class NavbarSettingLogic extends GetxController {

  final GlobalKey<ScaffoldState> scaffoldSettingKey = GlobalKey<ScaffoldState>();
  final selected = 0.obs;
  final selectedIndex = true.obs;
  final selectedIndex1 = false.obs;
  final selectedIndex2 = false.obs;
  final selectedIndex3 = false.obs;
  ScrollController scrollController = ScrollController();


  void changeIndex(int index){
    selected.value = index;
  }

}
