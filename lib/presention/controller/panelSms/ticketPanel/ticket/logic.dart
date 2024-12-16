// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:js';

import 'package:bors_web_admin_sms/presention/component/dialog_component/dialog_add_ticket/dialog_add_ticket.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../dataurl/constants/app_url.dart';
import '../../../../../dataurl/data/model/ticket-model.dart';
import '../../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../../component/alert/alert.dart';
import '../../../../component/dropdown_component/dropdown_component.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/shared_manager.dart';
import '../create_ticket_screen/logic.dart';


class TicketLogic extends GetxController {

  final TextEditingController txtChat = TextEditingController();
  final AppApiPanel apiServicePanel = AppApiPanel();
  ScrollController scrollController = ScrollController();
  final createTicketScreenLogic = Get.put(CreateTicketScreenLogic());
  final txtSearchTickets = TextEditingController();
  final tickets = <Ticket>[].obs;
  final ticketsSearch = <Ticket>[].obs;
  final isLoading = false.obs;


  final category = <TicketCategory>[].obs;
  final selectedTicket = ''.obs;
  final selectedTicketId = 1.obs;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    listTicket(context: context);
    listCategory(context: context);
  }
  void searchTickets(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = ticketsSearch.where((all) {
        final persianName = all.title.toLowerCase();
        return persianName.contains(input);
      }).toList();
      tickets.clear();
      tickets.addAll(suggestions);
    } else {
      tickets.clear();
      tickets.addAll(ticketsSearch);
    }
  }
  Future<void> listTicket ({context}) async {
    try {
      final response = await apiServicePanel.get(AppUrl.tickets, Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        tickets.clear();
        tickets.value = response.data.map<Ticket>((json) => Ticket.fromJson(json)).toList();
        ticketsSearch.value = response.data.map<Ticket>((json) => Ticket.fromJson(json)).toList();
        isLoading.value = false;
        // tickets.value = response.data['results'].map<Ticket>((json) => Ticket.fromJson(json)).toList();
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   scrollController.jumpTo(scrollController.position.maxScrollExtent);
        // });
      }
    } catch(e) {
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> listCategory ({context}) async{
    try{
      final response = await apiServicePanel.get(AppUrl.category, Options(headers:  {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if(response.statusCode == 200){
        category.clear();
        category.value = response.data.map<TicketCategory>((json) => TicketCategory.fromJson(json)).toList();

        if (category.isNotEmpty) {
          selectedTicket.value = category.first.name;
        }
      }
    }catch(e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void sentRequestAddTicket({context}){
    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      sendAddTicket(
          context,
          data: {
            'title': titleController.text,
            'description': descriptionController.text,
            'category': selectedTicketId.value.toString(),
          });
    } else {
      Alert(txt: 'خطا در اطلاعات وارد شده', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> sendAddTicket (context,{Map<String, dynamic>? data}) async{
    try{
      final response = await apiServicePanel.post(url: AppUrl.tickets ,data: data , options: Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}"}));
      if(response.statusCode == 201){
        listTicket(context: context);
        Navigator.of(context).pop();
      }
    }catch(e){
      Alert(txt: 'خطا در اطلاعات دربافتی', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void dialogMainCategoryList(context) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAddTicket(
          keyDropDown: _formKey,
          descriptionController: descriptionController,
          titleController: titleController,
          dropDown: Obx(() => DropDown(
            selectedDepartment: selectedTicket.value,
            items: category.map((cat) => DropdownMenuItem(
              value: cat.name,
              child: Text(cat.name),
            )).toList(),
            onChanged: (value) {
              selectedTicket.value = value!;
              var selectedCategory = category.firstWhere((cat) => cat.name == value);
              selectedTicketId.value = selectedCategory.id;
            },
          )),
          onPressSaveTicket: (){
            sentRequestAddTicket(context: context);
          },
        );
      },
    );
  }

}
