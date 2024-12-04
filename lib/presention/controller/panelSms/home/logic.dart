// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:js';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../dataurl/constants/app_url.dart';
import '../../../../dataurl/constants/app_url_DB.dart';
import '../../../../dataurl/data/model/grouplistmodel.dart';
import '../../../../dataurl/data/model/user-model-group.dart';
import '../../../../dataurl/data/network/api/app_api.dart';
import '../../../../dataurl/data/network/api/app_api_panel.dart';
import '../../../component/alert/alert.dart';
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


  final isGenerating = false.obs;
  final isReady = false.obs;
  final isReady2 = false.obs;
  final fileUrl = ''.obs;
  final List<Map<String, dynamic>> jsonData = [];

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

  void sendSMS({required id,required context}) async {
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
  Future<void> filterDataOffer({required data,required context,required id}) async {
    try {
      final response = await apiServiceShare.get('${AppUrlDB.offer}?$data', Options(headers: {
        'Content-Type': 'application/x-www-form-urlencoded',

      }));
      if (response.statusCode == 200) {
        results.addAll(response.data['results']);
        if(results.isEmpty){
          Alert(txt: 'هیچ موردی یافت نشد و پیامک ارسال نگردید',
              color: ColorManager.white,
              backgroundColor: ColorManager.red).showSnackBar(context);
        }else{
          sendSMS(id: id,context: context);
        }
        // final List<dynamic> responseData = response.data['results'] as List<dynamic>;
        // final List<Map<String, dynamic>> mappedData = responseData.map((item) => Map<String, dynamic>.from(item)).toList();
        // jsonData.addAll(mappedData);
        // showDownloadFileDialog(context);
      }
    } on DioException catch (e) {
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  // //dialog pdf and excel file
  // void showDownloadFileDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return WidgetDialogList(
  //           width: MediaQuery
  //               .of(context)
  //               .size
  //               .width / 3.6,
  //           column: Obx(() {
  //             return isGenerating.value ?
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const CircularProgressIndicator(),
  //                 const SizedBox(height: 20),
  //                 Text(isReady.value
  //                     ? "در حال ساخت فایل..."
  //                     : "در حال ایجاد گزارش..."),
  //               ],
  //             ):
  //             Column(
  //               mainAxisSize: MainAxisSize.min,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text('خروجی فایل',style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s16),),
  //                 const SizedBox(height: AppSize.s16),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     SelectBtn(
  //                       appSizeBtn: AppSize.s14,
  //                       appPaddingSelect: AppPadding.p24,
  //                       mainAxisAlignmentSelect: MainAxisAlignment.center,
  //                       visibleSelect: false,
  //                       iconSelect: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.paper,width: AppSize.s24,height: AppSize.s24,),
  //                       onPress: ()=> createExcelForWeb(),
  //                       text: "دانلود گزارش Excel",
  //                       borderColor: ColorManager.black.withOpacity(0.3),
  //                       radius: AppSize.s8,
  //                       heightBtn: AppSize.s64,
  //                       colorTextSelect: ColorManager.black,
  //                       backgroundColorSelect: ColorManager.gray,
  //                     ),
  //                     const SizedBox(width: AppSize.s16),
  //                     SelectBtn(
  //                       appSizeBtn: AppSize.s14,
  //                       appPaddingSelect: AppPadding.p24,
  //                       mainAxisAlignmentSelect: MainAxisAlignment.center,
  //                       visibleSelect: false,
  //                       iconSelect: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.paper,width: AppSize.s24,height: AppSize.s24,),
  //                       onPress: ()=> !isReady.value ?  createPdfForWeb(context) : null,
  //                       text: "ایجاد گزارش PDF",
  //                       borderColor: !isReady.value ? ColorManager.black.withOpacity(0.3) : ColorManager.black.withOpacity(0.1),
  //                       radius: AppSize.s8,
  //                       heightBtn: AppSize.s64,
  //                       colorTextSelect: !isReady.value ? ColorManager.black : ColorManager.black.withOpacity(0.6),
  //                       backgroundColorSelect: !isReady.value ? ColorManager.gray : ColorManager.gray.withOpacity(0.4),
  //                     ),
  //                   ],
  //                 ),
  //                 if (isReady.value)
  //                 const SizedBox(height: AppSize.s16),
  //                 if (isReady.value)
  //                 SelectBtn(
  //                   appSizeBtn: AppSize.s14,
  //                   appPaddingSelect: AppPadding.p16,
  //                   mainAxisAlignmentSelect: MainAxisAlignment.center,
  //                   visibleSelect: false,
  //                   iconSelect: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.download,width: AppSize.s24,height: AppSize.s24,),
  //                   onPress: ()=> downloadFile(),
  //                   text: "PDF دانلود فایل",
  //                   borderColor: ColorManager.black.withOpacity(0.3),
  //                   radius: AppSize.s8,
  //                   heightBtn: AppSize.s64,
  //                   colorTextSelect: ColorManager.black,
  //                   backgroundColorSelect: ColorManager.gray,
  //                 ),
  //               ],
  //             );
  //           }),
  //       );
  //     },
  //   );
  // }
  //
  // // create pdf and excel file or download
  // Future<void> createPdfForWeb(BuildContext context) async {
  //   isGenerating.value = true;
  //
  //   final pdf = await _generatePdf();
  //   final bytes = await pdf.save();
  //
  //   final blob = html.Blob([bytes], 'application/pdf');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //
  //   fileUrl.value = url;
  //   isGenerating.value = false;
  //   isReady.value = true;
  //   isReady2.value = false;
  // }
  //
  // void createExcelForWeb() async {
  //   final xls.Workbook workbook = xls.Workbook();
  //   final xls.Worksheet sheet = workbook.worksheets[0];
  //
  //   int rowIndex = 1;
  //
  //   for (var item in jsonData) {
  //     sheet.getRangeByIndex(rowIndex, 1, rowIndex, 2).merge();
  //     sheet.getRangeByIndex(rowIndex, 1).setText('آیتم ${rowIndex ~/ 2 + 1}');
  //     sheet
  //         .getRangeByIndex(rowIndex, 1)
  //         .cellStyle
  //         .bold = true;
  //     sheet
  //         .getRangeByIndex(rowIndex, 1)
  //         .cellStyle
  //         .fontSize = 14;
  //     rowIndex++;
  //
  //     item.forEach((key, value) {
  //       String persianKey = _convertToPersianKey(key);
  //       sheet.getRangeByIndex(rowIndex, 1).setText(persianKey);
  //       sheet.getRangeByIndex(rowIndex, 2).setText(value.toString());
  //       sheet
  //           .getRangeByIndex(rowIndex, 1)
  //           .cellStyle
  //           .hAlign = xls.HAlignType.right;
  //       sheet
  //           .getRangeByIndex(rowIndex, 2)
  //           .cellStyle
  //           .hAlign = xls.HAlignType.right;
  //       rowIndex++;
  //     });
  //   }
  //
  //   // Adjust column widths and save the file
  //   sheet
  //       .getRangeByIndex(1, 1)
  //       .columnWidth = 30;
  //   sheet
  //       .getRangeByIndex(1, 2)
  //       .columnWidth = 50;
  //
  //   List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();
  //
  //   final blob = html.Blob([Uint8List.fromList(bytes)],
  //       'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  //   final url = html.Url.createObjectUrlFromBlob(blob);
  //
  //   final anchor = html.AnchorElement(href: url)
  //     ..target = 'blank'
  //     ..download = "گزارش_داده‌ها.xlsx";
  //   anchor.click();
  //
  //   html.Url.revokeObjectUrl(url);
  // }
  //
  // String _convertToPersianKey(String key) {
  //   Map<String, String> keyMappings = {
  //     'id': 'شناسه',
  //     'commodityId_text': 'نام کالا',
  //     'tradingHallId_text': 'نام تالار',
  //     'buyMethodId': 'روش خرید',
  //     'brokerId': 'کارگزار',
  //     'contractTypeId': 'نوع قرارداد',
  //     'currencyId': 'واحد پول',
  //     'deliveryPlaceId': 'محل تحویل',
  //     'initPrice': 'قیمت پایه',
  //     'initVolume': 'حجم اولیه',
  //     'lotSize': 'اندازه هر بسته',
  //     'manufacturerId': 'تولید کننده',
  //     'maxInitPrice': 'حداکثر قیمت',
  //     'maxOrderVol': 'حداکثر حجم سفارش',
  //     'minInitPrice': 'حداقل قیمت',
  //     'description': 'توضیحات',
  //     'deliveryDate': 'تاریخ تحویل',
  //     'offerModeId': 'حالت عرضه',
  //     'offerTypeId': 'نوع عرضه',
  //     'minOfferVol': 'حداقل حجم عرضه',
  //     'prepaymentPercent': 'درصد پیش پرداخت'
  //   };
  //
  //   return keyMappings[key] ?? key;
  // }
  //
  // void downloadFile() {
  //   final anchor = html.AnchorElement(href: fileUrl.value)
  //     ..target = 'blank'
  //     ..download = 'گزارش.${isReady2.value == false ? "pdf" : "xlsx"}'
  //     ..click();
  //
  //   // Revoke the URL after the download has been triggered
  //   html.Url.revokeObjectUrl(fileUrl.value);
  //   isReady.value = false;
  // }
  //
  // Future<pw.Document> _generatePdf() async {
  //   final fontData = await rootBundle.load(
  //       'assets/fonts/IRANSansWeb_Medium.ttf');
  //   final ttf = pw.Font.ttf(fontData);
  //
  //   final pdf = pw.Document();
  //
  //   pdf.addPage(
  //     pw.MultiPage(
  //       pageFormat: PdfPageFormat.a4,
  //       textDirection: pw.TextDirection.rtl,
  //       build: (pw.Context context) {
  //         return [
  //           pw.Text(
  //             "گزارش اطلاعات کالا",
  //             style: pw.TextStyle(
  //               font: ttf,
  //               fontSize: 20,
  //               fontWeight: pw.FontWeight.bold,
  //             ),
  //           ),
  //           pw.SizedBox(height: 10),
  //           pw.Text(
  //             "تاریخ گزارش: ${DateTime.now()}",
  //             style: pw.TextStyle(font: ttf, fontSize: 12),
  //           ),
  //           pw.SizedBox(height: 20),
  //           pw.ListView.builder(
  //             itemCount: jsonData.length,
  //             itemBuilder: (context, index) {
  //               return pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                 children: [
  //                   pw.Text(
  //                     "آیتم ${index + 1}",
  //                     style: pw.TextStyle(
  //                       font: ttf,
  //                       fontSize: 16,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                   pw.SizedBox(height: 10),
  //                   pw.Table.fromTextArray(
  //                     headers: ["مقدار", "ویژگی"],
  //                     data: _convertJsonToData(jsonData[index]),
  //                     headerStyle: pw.TextStyle(
  //                       font: ttf,
  //                       fontSize: 12,
  //                       color: PdfColors.white,
  //                     ),
  //                     headerDecoration: const pw.BoxDecoration(
  //                         color: PdfColors.blue),
  //                     rowDecoration: const pw.BoxDecoration(
  //                       color: PdfColors.grey100,
  //                     ),
  //                     cellStyle: pw.TextStyle(
  //                       font: ttf,
  //                       fontSize: 10,
  //                     ),
  //                     border: pw.TableBorder.all(
  //                         width: 0.5, color: PdfColors.grey),
  //                   ),
  //                   pw.SizedBox(height: 20),
  //                 ],
  //               );
  //             },
  //           ),
  //         ];
  //       },
  //     ),
  //   );
  //
  //   return pdf;
  // }
  //
  // List<List<String>> _convertJsonToData(Map<String, dynamic> item) {
  //   final translatedKeys = {
  //     "id": "شناسه",
  //     "commodityId_text": "نام کالا",
  //     "tradingHallId_text": "تالار",
  //     "buyMethodId": "روش خرید",
  //     "brokerId": "کارگزار",
  //     "contractTypeId": "نوع قرارداد",
  //     "currencyId": "واحد پول",
  //     "deliveryPlaceId": "محل تحویل",
  //     "initPrice": "قیمت اولیه",
  //     "initVolume": "حجم اولیه",
  //     "lotSize": "اندازه لات",
  //     "manufacturerId": "تولیدکننده",
  //     "maxInitPrice": "بیشینه قیمت اولیه",
  //     "maxOrderVol": "بیشینه حجم سفارش",
  //     "minInitPrice": "کمینه قیمت اولیه",
  //     "description": "توضیحات",
  //     "deliveryDate": "تاریخ تحویل",
  //     "offerModeId": "حالت عرضه",
  //     "offerTypeId": "نوع عرضه",
  //     "minOfferVol": "کمینه حجم عرضه",
  //     "prepaymentPercent": "درصد پیش‌پرداخت",
  //   };
  //
  //   return item.entries
  //       .map((entry) =>
  //   [
  //     entry.value.toString(),
  //     translatedKeys[entry.key] ?? entry.key,
  //   ])
  //       .toList();
  // }
}
