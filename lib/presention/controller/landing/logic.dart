import 'package:get/get.dart';
import '../login/logic.dart';
import '../panelSms/addmember/logic.dart';
import '../panelSms/home/logic.dart';

class LandingLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());
  final loginLogic = Get.put(LoginLogic());
}
