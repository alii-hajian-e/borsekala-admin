// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:js';
import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:bors_web_admin_sms/presention/component/error/error_overlay.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/constants/app_url_DB.dart';
import '../../../../dataurl/data/model/grouplistmodel.dart';
import '../../../../dataurl/data/model/user-model-group.dart';
import '../../../../dataurl/data/network/api/app_api.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
import '../../../component/button_component/circle-btn/circle_btn.dart';
import '../../../component/dialog_component/dialog-list/dialog_list.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/shared_manager.dart';

class HomeLogic extends GetxController with StateMixin<dynamic> {

  final groupList = <GroupList>[].obs;
  final groupListSearch = <GroupList>[].obs;
  final txtSearch = TextEditingController();
  final txtSearchUser = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerListView = ScrollController();
  final AppApiPanel apiServicePanel = AppApiPanel();
  final AppApi apiServiceShare = AppApi();

  var isCheckedList = <Model>[].obs;
  var isCheckedListSearch = <Model>[].obs;
  final List results = [];

  final selectedType = "pdf".obs;
  // final selectedTheme = "Minimal".obs;

  // final List<String> availableThemes = ["Minimal", "Colorful", "Advanced"].obs;
  final List<String> availableColumns = [
    "id",
    "commodityId_text",
    "tradingHallId_text",
    "buyMethodId",
    "brokerId",
    "contractTypeId",
    "currencyId",
    "deliveryPlaceId",
    "initPrice",
    "initVolume",
    "lotSize",
    "manufacturerId",
    "maxInitPrice",
    "maxIncOfferVol",
    "maxOrderVol",
    "maxOfferPrice",
    "measureUnitId",
    "minAllocationVol",
    "minOfferVol",
    "minInitPrice",
    "minOrderVol",
    "minOfferPrice",
    "offerModeId",
    "offerTypeId",
    "offerVol",
    "packagingTypeId",
    "permissibleError",
    "priceDiscoveryMinOrderVol",
    "prepaymentPercent",
    "securityTypeId",
    "settlementTypeId",
    "supplierId",
    "tickSize",
    "weightFactor",
    "deliveryDate",
    "offerDate",
    "offerRing",
    "offerSymbol",
    "tradeStatus",
    "description"
  ].obs;

  final downloadUrl = ''.obs;
  final selectedColumns = [].obs;
  final jsonData = [].obs;
  final validDownload = false.obs;


  @override
  void onInit() {
    super.onInit();
    getPanelRoom(context);
  }

  @override
  void onClose() {
    scrollController.dispose();
    scrollControllerListView.dispose();
    super.onClose();
  }

  void getPanelRoom(context) async {
    try {
      final response = await apiServicePanel.get(
          AppUrl.panelRoom, Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 200) {
        // String jsonString = jsonEncode(getResponse.body);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        groupList.clear();
        groupListSearch.clear();
        groupList.value = (response.data['results']).map<GroupList>((json) =>
            GroupList.fromJson(json)).toList();
        groupListSearch.value =
            (response.data['results']).map<GroupList>((json) =>
                GroupList.fromJson(json)).toList();
      }
    } on DioException catch (e) {
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void sendSMS({required id, required context}) async {
    try {
      final response = await apiServicePanel.get(
          '${AppUrl.sendSms}$id', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 204) {
        Alert(txt: 'پیامک تستی ارسال شد',
            color: ColorManager.white,
            backgroundColor: ColorManager.green).showSnackBar(context);
      }
    } on DioException catch (e) {
      Alert(txt: 'پیامک تستی ارسال نشد',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void searchUser(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = isCheckedListSearch.where((all) {
        final name = all.user.name.toLowerCase();
        return name.contains(input);
      }).toList();
      isCheckedList.clear();
      isCheckedList.addAll(suggestions);
    } else {
      isCheckedList.clear();
      isCheckedList.addAll(isCheckedListSearch);
    }
  }

  void search(String query) {
    final input = query.toLowerCase();
    if (input.isNotEmpty) {
      final suggestions = groupListSearch.where((all) {
        final name = all.name!.toLowerCase();
        return name.contains(input);
      }).toList();
      groupList.clear();
      groupList.addAll(suggestions);
    } else {
      groupList.clear();
      groupList.addAll(groupListSearch);
    }
  }

  Future<void> listUser(id, context) async {
    try {
      final response = await apiServicePanel.get(
          '${AppUrl.userGroupList}?room=$id', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}"
      }));
      if (response.statusCode == 200) {
        // String jsonString = jsonEncode(response.data['results']);
        // dynamic decodedJson = jsonDecode(utf8.decode(jsonString.runes.toList()));
        isCheckedList.clear();
        isCheckedListSearch.clear();
        isCheckedList.value = response.data['results']
            .map<Model>((json) => Model.fromJson(json))
            .toList();
        isCheckedListSearch.value = response.data['results']
            .map<Model>((json) => Model.fromJson(json))
            .toList();
      }
    } on DioException catch (e) {
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  // call api filter
  Future<void> filterDataOffer(
      {required data, required context, required id}) async {
    try {
      final response = await apiServiceShare.get(
          '${AppUrlDB.offer}?$data', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',

      }));
      if (response.statusCode == 200) {
        if (validDownload.value == false) {
          results.addAll(response.data['results']);
          if (results.isEmpty) {
            Alert(txt: 'هیچ موردی یافت نشد و پیامک ارسال نگردید',
                color: ColorManager.white,
                backgroundColor: ColorManager.red).showSnackBar(context);
          } else {
            sendSMS(id: id, context: context);
          }
        } else {
          final List<dynamic> responseData = response.data['results'] as List<dynamic>;
          final List<Map<String, dynamic>> mappedData = responseData.map((item) => Map<String, dynamic>.from(item)).toList();
          jsonData.addAll(mappedData);
          showDownloadFileDialog(context);
        }
      }
    } on DioException catch (e) {
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  Future<void> generateFile({required context}) async {
    if (selectedColumns.isEmpty) {
      CustomOverlayMessage.show(
        context,
        message: "ستونی را انتخاب نکرده اید.",
        duration: const Duration(seconds: 2),
        backgroundColor: ColorManager.black,
        textColor: ColorManager.white,
      );
    }
    final fileData = jsonEncode({
      "type": selectedType.value,
      "columns": selectedColumns,
      // "theme": selectedTheme.value, // ارسال تم
      "data": jsonData,
    });
    await fileDownload(data: fileData, context: context);
  }
  Future<void> fileDownload({
    required String data,
    required BuildContext context,
  }) async {
    try {
      final response = await Dio().post(
        AppUrl.downloadFile,
        data: data,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final filePath = response.data["file_path"];
        downloadUrl.value =
        "https://panel.ibrokers.ir/generator/download-file/?file_path=$filePath";
      } else {
        Alert(
          txt: 'خطا در تولید فایل: ${response.statusMessage}',
          color: ColorManager.white,
          backgroundColor: ColorManager.red,
        ).showSnackBar(context);
      }
    } on DioException catch (e) {
      Alert(
        txt: 'خطا در ارسال اطلاعات: ${e.message}',
        color: ColorManager.white,
        backgroundColor: ColorManager.red,
      ).showSnackBar(context);
    }
  }
  void showDownloadFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
          width: MediaQuery
              .of(context)
              .size
              .width ,
          column: Obx(() {
            return Padding(
              padding: const EdgeInsets.all(AppSize.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: ()=>
                                Navigator.of(context).pop(),
                            child: Row(
                              children: [
                                Container(
                                  width: AppSize.s32,
                                  height: AppSize.s32,
                                  decoration: BoxDecoration(
                                    color: ColorManager.gray,
                                    borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                                  ),
                                  child: CircleButton(
                                    appSize: AppSize.s8,
                                    widthCircle: AppSize.s32,
                                    heightCircle: AppSize.s32,
                                    buttonColorCircle: ColorManager.gray.withOpacity(0.0),
                                    onPress: null,
                                    icons: const Icon(Icons.clear,size: AppSize.s18),
                                    colors: ColorManager.gray,
                                    bordersSide: AppSize.s2,
                                    borderSideColors: ColorManager.gray,
                                  ),
                                ),
                                const SizedBox(width: AppSize.s16),
                                Text(
                                  'بستن',
                                  style: getBoldStyle(
                                      color: ColorManager.black, fontSize: AppSize.s14),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSize.s32),
                          Text("انتخاب نوع فایل:", style: getMediumStyle(
                              color: ColorManager.black.withOpacity(0.6),
                              fontSize: AppSize.s14),),
                          const SizedBox(width: AppSize.s16),
                          Container(
                            height: AppSize.s40,
                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.black.withOpacity(0.4),width: AppSize.s1),
                              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                            ),
                            child: DropdownButton<String>(
                              underline: const SizedBox(),
                              value: selectedType.value,
                              onChanged: (value) {
                                selectedType.value = value!;
                              },
                              items: ["pdf", "excel"]
                                  .map((type) =>
                                  DropdownMenuItem(
                                    value: type,
                                    child: Text(type.toUpperCase(),
                                      style: getMediumStyle(color: ColorManager.black,
                                          fontSize: AppSize.s14),),
                                  ))
                                  .toList(),
                            ),
                          ),
                          // const SizedBox(width: AppSize.s32),
                          // Text("انتخاب تم فایل:", style: getMediumStyle(
                          //     color: ColorManager.black.withOpacity(0.6),
                          //     fontSize: AppSize.s14),),
                          // const SizedBox(width: AppSize.s16),
                          // Container(
                          //   height: AppSize.s40,
                          //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: ColorManager.black.withOpacity(0.4),width: AppSize.s1),
                          //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                          //   ),
                          //   child: DropdownButton<String>(
                          //     underline: const SizedBox(),
                          //     value: selectedTheme.value,
                          //     onChanged: (value) {
                          //       selectedTheme.value = value!;
                          //     },
                          //     items: availableThemes
                          //         .map((theme) =>
                          //         DropdownMenuItem(
                          //           value: theme,
                          //           child: Text(theme, style: getMediumStyle(
                          //               color: ColorManager.black,
                          //               fontSize: AppSize.s14),),
                          //         ))
                          //         .toList(),
                          //   ),
                          // ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if(selectedColumns.isNotEmpty)
                            Btn(
                              buttonColorBtn: downloadUrl.value.isEmpty ? ColorManager.yellow : ColorManager.gray,
                              onPress: () => downloadUrl.value.isEmpty ? generateFile(context: context) : null,
                              text: "ایجاد فایل",
                              heightBtn: AppSize.s40,
                              borderRadiusBtn: AppSize.s8,
                              buttonTextColorBtn: downloadUrl.value.isEmpty ? ColorManager.black : ColorManager.black.withOpacity(0.6),
                              borderSideColorBtn: downloadUrl.value.isEmpty ? ColorManager.yellow : ColorManager.gray,
                            ),
                          if (downloadUrl.value.isNotEmpty)
                            const SizedBox(width: AppSize.s24),
                          if (downloadUrl.value.isNotEmpty)
                            Btn(
                              buttonColorBtn: ColorManager.yellow,
                              onPress: () {
                                launch(downloadUrl.value);
                                downloadUrl.value = '';
                              },
                              text: "دانلود فایل",
                              heightBtn: AppSize.s40,
                              borderRadiusBtn: AppSize.s8,
                              buttonTextColorBtn: ColorManager.black,
                              borderSideColorBtn: ColorManager.yellow,
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSize.s24),
                  Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4)),
                  const SizedBox(height: AppSize.s24),
                  Text("انتخاب ستون‌ها:", style: getMediumStyle(
                      color: ColorManager.black.withOpacity(0.8),
                      fontSize: AppSize.s14),),
                  const SizedBox(height: AppSize.s8),
                  Expanded(
                    child: ListView(
                      children: availableColumns.map((column) {
                        return CheckboxListTile(
                          activeColor: ColorManager.black,
                          title: Text(column, style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: AppSize.s14),),
                          value: selectedColumns.contains(column),
                          onChanged: (bool? value) {
                            if (value == true) {
                              if (selectedColumns.length < 8) {
                                selectedColumns.add(column);
                              } else {
                                CustomOverlayMessage.show(
                                  context,
                                  message: "شما می‌توانید حداکثر 8 ستون انتخاب کنید.",
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: ColorManager.black,
                                  textColor: ColorManager.white,
                                );
                              }
                            } else {
                              selectedColumns.remove(column);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
  // Future<void> fileDownload({Map<String, dynamic>? data, context}) async {
  //   try {
  //     final response = await apiServicePanel.post(
  //       url: AppUrl.downloadFile,
  //       data: data,
  //       options: Options(headers: {"Content-Type": "application/json"}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final filePath = response.data["file_path"];
  //       downloadUrl.value = "https://panel.ibrokers.ir/generator/download-file/?file_path=$filePath";
  //     }
  //   } on DioException catch (e) {
  //     Alert(
  //       txt: 'اطلاعات وارد شده اشتباه است',
  //       color: ColorManager.white,
  //       backgroundColor: ColorManager.red,
  //     ).showSnackBar(context);
  //   }
  // }

  //dialog pdf and excel file


}
