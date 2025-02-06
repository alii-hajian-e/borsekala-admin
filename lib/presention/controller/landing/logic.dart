
// ignore_for_file: avoid_web_libraries_in_flutter


import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../login/logic.dart';
import '../panelSms/addmember/logic.dart';
import '../panelSms/home/logic.dart';
import '../panelSms/ticketPanel/ticket/logic.dart';

class LandingLogic extends GetxController {
  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());
  final loginLogic = Get.put(LoginLogic());
  final ticketLogic = Get.put(TicketLogic());

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

}
