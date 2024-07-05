import 'package:get/get.dart';
import '../addmember/logic.dart';
import '../home/logic.dart';
import '../login/logic.dart';

class LandingLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());
  final loginLogic = Get.put(LoginLogic());

}
