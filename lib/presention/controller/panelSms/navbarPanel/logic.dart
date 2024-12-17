
import 'package:get/get.dart';


class NavbarPanelLogic extends GetxController {

  final selected = 0.obs;
  final selectedIndex = true.obs;
  final selectedIndex1 = false.obs;
  final selectedIndex2 = false.obs;
  final selectedIndex3 = false.obs;

  void changeIndex(int index){
    selected.value = index;
  }
}
