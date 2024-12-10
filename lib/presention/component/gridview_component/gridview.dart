import 'package:bors_web_admin_sms/presention/component/alert/alert.dart';
import 'package:bors_web_admin_sms/widget/scrollBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../dataurl/data/model/getdatagroupapi.dart';
import '../../../dataurl/data/model/group-model.dart';
import '../../../dataurl/data/model/grouplistmodel.dart';
import '../../../dataurl/data/model/main-group-model.dart';
import '../../../dataurl/data/model/trading-hall-model.dart';
import '../../controller/panelSms/addgroupe/logic.dart';
import '../../controller/panelSms/addmember/logic.dart';
import '../../controller/panelSms/home/logic.dart';
import '../../controller/panelSms/navbarPanel/logic.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';
import '../button_component/btn/_btn.dart';
import '../dialog_component/dialog-more/dialog.dart';
import '../item_list_category/item_list_category.dart';

final addGroupLogic = Get.put(AddGroupLogic());
final addMemberLogic = Get.put(AddMemberLogic());
final homeLogic = Get.put(HomeLogic());

class GridViewPage extends StatelessWidget {

  final RxList<GroupList> items;

  final bool activeCheckBox;
  final bool isCheckedAll;
  final dynamic onTapCheckBoxAll;
  final dynamic onChanged;
  final dynamic textFieldController;
  final dynamic childBtnDelete;
  final dynamic child;

  final bool visibleBtn;
  final bool visibleBtnSms;
  final bool visibleEdit;
  final double childAspectRatio;
  final ScrollController controllerGridView;


  const GridViewPage({super.key, required this.items,required this.child, required this.activeCheckBox, required this.isCheckedAll, this.onTapCheckBoxAll,required this.onChanged,required this.textFieldController, required this.visibleBtn, required this.visibleEdit, required this.childAspectRatio, required this.visibleBtnSms, required this.childBtnDelete, required this.controllerGridView});


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return ScrollBarWidget(
          controllerScrollBar: controllerGridView,
          childUi: GridView.builder(
            controller: controllerGridView,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppSize.s16,
              mainAxisSpacing: AppSize.s16,
              childAspectRatio: childAspectRatio,
            ),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              GroupList fetchGroupList = items[index];
              Group group = GetDateGroupApi().findGroupById(fetchGroupList.group);
              MainGroup mainGroup = GetDateGroupApi().findMainGroupById(fetchGroupList.mainGroup);
              TradingHall findTradingHallById = GetDateGroupApi().findTradingHallById(fetchGroupList.hallId);
              DateTime dateTime = DateTime.parse(fetchGroupList.createdAt.toString());
              Jalali jalaliDate = Jalali.fromDateTime(dateTime);

              return ItemListCategory(
                visibleBtn: visibleBtn,
                visibleEdit: visibleEdit,
                visibleBtnSms: visibleBtnSms,
                onPressDownloadFile: (){
                  filterData(index: index, id: fetchGroupList.id.toString(), context: context, validDownload: true);
                  // homeLogic.validDownload.value = true;
                  // homeLogic.filterDataOffer(
                  //   id: fetchGroupList.id,
                  //   context: context,
                  //   data: 'start_date=${startData2.value.replaceAll('00:00:00.000', '')}&end_date=${endDate2.value.replaceAll(' 00:00:00.000', '')}&main=${mainGroup2.toString()}&group=${group2.toString()}&sub=${subGroup2.toString()}&hall=${hallId2.toString()}&page=1&manufacturer=${manufacturer2.toString()}&search=',
                  // );
                },
                onPressBtnDelete: (){
                  addGroupLogic.dialogEducation(context, fetchGroupList.id);
                },
                onPressBtnEdit: (){
                  addGroupLogic.nameSubCategoryList.clear();
                  addGroupLogic.idSubCategoryList.clear();
                  addGroupLogic.nameCompanyList.clear();
                  addGroupLogic.idCompanyList.clear();
                  addGroupLogic.fetchTradingHallList();
                  addGroupLogic.fetchCompanyList();
                  addGroupLogic.fetchMainGroupEdit(fetchGroupList.mainGroup);
                  addGroupLogic.fetchGroupEdit(fetchGroupList.group);
                  addGroupLogic.fetchSubCategoryEdit(fetchGroupList.subGroup);
                  addGroupLogic.fetchTradingHallEdit(fetchGroupList.hallId);
                  addGroupLogic.numberDay.value = fetchGroupList.cronJobFutureDays ?? 0;
                  addGroupLogic.numberTime.value = fetchGroupList.cronJobTime ?? 0;
                  fetchDataCompanyEdite(fetchGroupList.manufacturer);
                  addGroupLogic.txtNameUser.text = fetchGroupList.name.toString();
                  int index = addGroupLogic.getIndexById(addGroupLogic.subTradingList, addGroupLogic. idTradingList.value);
                  addGroupLogic.idSelectList.value = index;
                  addGroupLogic.dialogAddGroup(
                      context,
                      txtBtn1: 'انصراف',
                      txtAlert: 'ویرایش گروه',
                      hintText: fetchGroupList.name.toString(),
                      btn: Expanded(
                        child: Btn(
                          buttonColorBtn: ColorManager.yellow,
                          onPress: (){
                            addGroupLogic.editGroupRequest(fetchGroupList.id,context);
                          },
                          text: 'ویرایش',
                          heightBtn: AppSize.s48,
                          borderRadiusBtn: AppSize.s8,
                          buttonTextColorBtn: ColorManager.black,
                          borderSideColorBtn: ColorManager.gray1.withOpacity(0),
                        ),
                      )
                  );
                },
                onTapGroup: (){
                  final navbarLogic = Get.put(NavbarPanelLogic());
                  addGroupLogic.nameSubCategoryList.clear();
                  addGroupLogic.idSubCategoryList.clear();
                  if(navbarLogic.selected.value == 0){
                    addGroupLogic.fetchSubCategoryEdit(fetchGroupList.subGroup);
                    fetchDataCompanyEdite(fetchGroupList.manufacturer);
                    homeLogic.listUser(fetchGroupList.id.toString() , context);
                    dialogEducation(
                      context: context,
                      name: fetchGroupList.name.toString(),
                      grouping: group.persianName.toString(),
                      company: addGroupLogic.nameCompanyListString.value,
                      mainCategory: mainGroup.persianName.toString(),
                      nameGroup: findTradingHallById.persianName.toString(),
                      number: int.parse(fetchGroupList.userCount.toString()),
                      subset: addGroupLogic.nameSubCategoryListString.value,
                      visibleBtnUser: false,
                      onPressAddUser: null,
                    );
                  }else{
                    null;
                  }
                },
                onPressBtn: (){
                  final addMemberLogic = Get.put(AddMemberLogic());
                  addGroupLogic.nameSubCategoryList.clear();
                  addGroupLogic.idSubCategoryList.clear();
                  addMemberLogic.pageUserGroup.value = 1;
                  addMemberLogic.getUserList(context);
                  addGroupLogic.id.value = fetchGroupList.id.toString();
                  addGroupLogic.fetchSubCategoryEdit(fetchGroupList.subGroup);
                  homeLogic.listUser(fetchGroupList.id.toString() , context);
                  fetchDataCompanyEdite(fetchGroupList.manufacturer);

                  dialogEducation(
                    context: context,
                    name: fetchGroupList.name.toString(),
                    grouping: group.persianName.toString(),
                    company: addGroupLogic.nameCompanyListString.value,
                    mainCategory: mainGroup.persianName.toString(),
                    nameGroup: findTradingHallById.persianName.toString(),
                    number: int.parse(fetchGroupList.userCount.toString()),
                    subset: addGroupLogic.nameSubCategoryListString.value,
                    visibleBtnUser: true,
                    onPressAddUser: (){
                      // addMemberLogic.getUserList(context);
                      addGroupLogic.dialogAddListUser(fetchGroupList.id.toString(),context);
                      addGroupLogic.sortListUser();

                    },
                  );
                },
                onPressBtnSms: (){
                  if(fetchGroupList.userCount != 0){
                    Alert(txt: 'لطفا صبر کنید', color: ColorManager.black, backgroundColor: ColorManager.yellow).showSnackBar(context);
                    // homeLogic.sendSMS(fetchGroupList.id,context);
                    filterData(index: index, id: fetchGroupList.id.toString(), context: context, validDownload: false);
                  }else{
                    Alert(txt: 'هیچ کاربری به گروه اضافه نشده است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
                  }
                },
                name: fetchGroupList.name.toString(),
                num: fetchGroupList.userCount.toString(),
                mainCategory: mainGroup.persianName.toString(),
                grouping: group.persianName.toString(),
                subset: addGroupLogic.fetchSubCategoryEditGroup(fetchGroupList.subGroup),
                manufacturer: fetchDataCompany(fetchGroupList.manufacturer),
                nameGroup: findTradingHallById.persianName.toString(),
                time: '${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}',
              );
            },
          ),
        );
      }),
    );
  }

  String fetchDataCompany(fetchGroupList){
    switch(fetchGroupList) {
      case '0':
      case '':
        return 'ندارد';
      default:
        return addGroupLogic.fetchCompanyEditGroup(fetchGroupList);
    }
  }
  fetchDataCompanyEdite(fetchGroupList){
    switch(fetchGroupList) {
      case "0":
      case '':
        return addGroupLogic.nameCompanyListString.value = 'ندارد';
      default:
        return addGroupLogic.fetchCompanyEdit(fetchGroupList);
    }
  }
  void filterData({required int index , required String id,required context , required bool validDownload}){
    final group2 = items[index].group;
    final hallId2 = items[index].hallId;
    final mainGroup2 = items[index].mainGroup;
    final manufacturer2 = items[index].manufacturer;
    final subGroup2 = items[index].subGroup;
    final startData2 = Jalali.now().toDateTime().toString().obs;
    final endDate2 = Jalali.now().toDateTime().toString().obs;

    startData2.value = Jalali.now().toDateTime().toString();
    Jalali oneMonthLater2 = Jalali.now().addDays(2);
    endDate2.value = oneMonthLater2.toDateTime().toString();
    homeLogic.validDownload.value = validDownload;

    homeLogic.filterDataOffer(
      id: id,
      context: context,
      data: 'start_date=${startData2.value.replaceAll('00:00:00.000', '')}&end_date=${endDate2.value.replaceAll(' 00:00:00.000', '')}&main=${mainGroup2.toString()}&group=${group2.toString()}&sub=${subGroup2.toString()}&hall=${hallId2.toString()}&page=1&manufacturer=${manufacturer2.toString()}&search=',
    );
  }
  void dialogEducation(
      {context, name, grouping, mainCategory, nameGroup, number, subset, company, visibleBtnUser, onPressAddUser}){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialog(

          visibleBtnUser: visibleBtnUser,
          onPressAddUser: onPressAddUser,
          name: name,
          grouping: grouping,
          mainCategory: mainCategory,
          nameGroup: nameGroup,
          num: number,
          subset: subset,
          company: company,

          isCheckedAll: isCheckedAll,
          activeCheckBox: activeCheckBox,
          onTapCheckBoxAll: onTapCheckBoxAll,
          onChanged: onChanged,
          textFieldController: textFieldController,
          childBtnDelete: childBtnDelete,
          child: child,
        );
      },
    );
  }
}