import 'package:get/get.dart';
import '../addmember/logic.dart';
import '../home/logic.dart';

class LandingLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());

}
