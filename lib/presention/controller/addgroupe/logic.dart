import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:bors_web_admin_sms/presention/component/item_list_subCategory/item_list_subCategory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../dataurl/constants/app_url.dart';
import '../../../dataurl/data/model/getdatagroupapi.dart';
import '../../../dataurl/data/model/group-model.dart';
import '../../../dataurl/data/model/main-group-model.dart';
import '../../../dataurl/data/model/sub-group-model.dart';
import '../../../dataurl/data/model/trading-hall-model.dart';
import '../../../dataurl/data/model/user-list-model.dart';
import '../../../dataurl/data/network/api/app_api_panel.dart';
import '../../component/alert/alert.dart';
import '../../component/button_component/circle-btn/circle_btn.dart';
import '../../component/dialog_component/dialog-list/dialog_list.dart';
import '../../component/dialog_component/dialog_action/dialod_action.dart';
import '../../component/dialog_component/dialog_add_delete_group/dialog_add_delete_group.dart';
import '../../component/item_list_user/item_list_user.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/shared_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import '../addmember/logic.dart';
import '../home/logic.dart';
import '../navbar/logic.dart';

class AddGroupLogic extends GetxController {

  final homeLogic = Get.put(HomeLogic());
  final addMemberLogic = Get.put(AddMemberLogic());
  final navbarLogic = Get.put(NavbarLogic());
  final AppApiPanel apiServicePanel = AppApiPanel();
  final txtNameUser = TextEditingController();

  final mainCategoryList = <MainGroup>[].obs;
  final categoryList = <Group>[].obs;
  final subTradingList = <TradingHall>[].obs;
  final subCategoryList = <SubGroup>[].obs;
  final companyList = <Company>[].obs;
  final nameMainCategoryList = 'انتخاب کنید'.obs;
  final nameCategoryList = 'انتخاب کنید'.obs;
  final nameSubCategoryListEdite = 'انتخاب کنید'.obs;
  final nameCompanyListEdite = 'انتخاب کنید'.obs;

  final nameSubCategoryList = [].obs;
  final nameCompanyList = [].obs;

  final nameSubCategoryListString = 'انتخاب کنید'.obs;
  final nameCompanyListString = 'انتخاب کنید'.obs;
  final idMainCategoryList = 0.obs;
  final idCategoryList = 0.obs;
  final idSubCategoryList = [].obs;
  final idCompanyList = [].obs;

  final idSelectList = 100.obs;
  final idTradingList = 100.obs;
  final visibleDeleteUserGroup = false.obs;
  final load = false.obs;

  final idUser = [].obs;
  final addIdUser = [].obs;

  final id = ''.obs;

  void sortListUser (){
    var ids = [];

    for (var element in homeLogic.isCheckedList) {
      ids.add(element.user.id);}

    addMemberLogic.listUser.value = addMemberLogic.listUser.where((p0) =>
      !ids.contains(p0.id)
    ).toList();
  }

  void dialogDeleteUserGroup(context){
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.trash,width: AppSize.s24,height: AppSize.s24),
          txtAlert: 'کاربران انتخاب شده حذف شود ؟',
          txtBtn1: 'خیر',
          txtBtn: 'بله',
          onPress: () {
            deleteUserGroupRequest(id, context);
            GoRouter.of(context).pop();
          },
          onPress1: (){
            // Get.back();
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }
  void deleteUserGroupRequest(id,context) {
    String result = idUser.join(', ');
    deleteUserGroup(context, id: id, data: {
      'users': result,
    });

  }
  Future<void> deleteUserGroup(context, {Map<String, dynamic>? data, id}) async {
    try {
      final response = await apiServicePanel.delete(
          '${AppUrl.addUserGroup}$id',data: data, Options(headers: {
       // 'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      },));
      if (response.statusCode == 201) {
        homeLogic.getPanelRoom(context);
        homeLogic.listUser(id , context);
        idUser.clear();
        visibleDeleteUserGroup.value = false;
      }
    } on DioException catch (e) {
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void addGroupRequest(context) {
    if (txtNameUser.text.isNotEmpty && idSelectList.value != 100 && idMainCategoryList.value != 0 && idCategoryList.value != 0 && idSubCategoryList.isNotEmpty) {
      load.value = true;
      String idSubCategoryListString = idSubCategoryList.join(', ');
      String idCompanyListString = idCompanyList.join(', ');
      groupRequest(context, data: {
        'name': txtNameUser.text.toString(),
        'main_group': idMainCategoryList.value,
        'group': idCategoryList.value == 0 ? 0 : idCategoryList.value,
        'sub_group': idSubCategoryListString == ''
            ? '0'
            : idSubCategoryListString,
        'manufacturer': idCompanyListString == ''
            ? '0'
            : idCompanyListString,
        'hall_id': idTradingList.value == 0 ? 0 : idTradingList.value,

      });
    } else {
      Alert(txt: 'اطلاعات تکمیل نیس',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> groupRequest(context, {Map<String, dynamic>? data}) async {
    try {
      final response = await apiServicePanel.post(
          url: AppUrl.panelRoom,data: data, options: Options(headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 201) {
        txtNameUser.clear();
        nameMainCategoryList.value = '';
        nameCategoryList.value = '';
        nameSubCategoryList.value = [];
        nameCompanyList.value = [];
        idSelectList.value = 0;
        load.value = false;
        GoRouter.of(context).pop();
        homeLogic.getPanelRoom(context);
        homeLogic.groupList.refresh();
      }
    } on DioException catch (e) {
      load.value = false;
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void editGroupRequest(id, context) {
    if (txtNameUser.text.isNotEmpty && idSelectList.value != 100 && idMainCategoryList.value != 0 && idCategoryList.value != 0 && idSubCategoryList.isNotEmpty) {
      String idSubCategoryListString = idSubCategoryList.join(', ');
      String idCompanyListString = idCompanyList.join(', ');
      editGroup(context, id: id, data: {
        'name': txtNameUser.text,
        'main_group': idMainCategoryList.value,
        'group': idCategoryList.value,
        'sub_group': idSubCategoryListString,
        'manufacturer': idCompanyListString,
        'hall_id': idTradingList.value,

      });
    } else {
      Alert(txt: 'اطلاعات تکمیل نیس',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  Future<void> editGroup(context, {Map<String, dynamic>? data, id}) async {
    try {
      final response = await apiServicePanel.patch(
          url: '${AppUrl.panelRoom}$id/', data: data,  options: Options(headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 200) {
        txtNameUser.clear();
        nameMainCategoryList.value = '';
        nameCategoryList.value = '';
        nameSubCategoryList.value = [];
        nameCompanyList.value = [];
        idSelectList.value = 0;
        homeLogic.getPanelRoom(context);
        homeLogic.groupList.refresh();
        GoRouter.of(context).pop();
        // homeLogic.groupList.refresh();
      }
    } on DioException catch (e){
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

  void deleteGroupList(id, context) async {
    try {
      final response = await apiServicePanel.delete(
          '${AppUrl.panelRoom}$id/',data: null, Options(headers:{
        'Content-Type': 'application/x-www-form-urlencoded',
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 204) {
        GoRouter.of(context).pop();
        homeLogic.getPanelRoom(context);
        homeLogic.groupList.refresh();
      }
    } on DioException catch (e){
      addIdUser.clear();
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }
  void dialogEducation(context, id) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogAction(
          icons: SvgPicture.asset(fit: BoxFit.scaleDown,
              ImageAssets.trash,
              width: AppSize.s24,
              height: AppSize.s24),
          txtAlert: 'این گروه حذف شود ؟',
          txtBtn1: 'انصراف',
          txtBtn: 'حذف',
          onPress: () {
            deleteGroupList(id, context);
          },
          onPress1: () {
            GoRouter.of(context).pop();
          },
        );
      },
    );
  }
  void dialogAddGroup(context, {txtAlert, txtBtn1,hintText,btn}) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogAdd_DeleteGroup(
          hintText: hintText,
          buttonColorBtn1: ColorManager.gray1,
          textFieldController: txtNameUser,
          txtHintGroup: nameMainCategoryList,
          txtHintMainGroup: nameCategoryList,
          txtHintSubGroup: nameSubCategoryListString,
          txtHintCompany: nameCompanyListString,
          onPressGroup: () {
            fetchCategoryList();
            dialogMainCategoryList(context, mainCategoryList);
          },
          onPressMainGroup: () {
            fetchMainCategoryList(idMainCategoryList.value);
            dialogCategoryList(context, categoryList);
          },
          onPressSubGroup: () {
            fetchSubCategoryList(idCategoryList.value);
            dialogSubCategoryList(context, subCategoryList);
          },
          onPressCompany: (){
            fetchCompanyList();
            dialogCompanyList(context, companyList);
          },
          txtAlert: txtAlert,
          txtBtn1: txtBtn1,
          btn: btn,
          onPress1: () {
            GoRouter.of(context).pop();
          },
          child: Expanded(
            // height: AppSize.s140,
            child: Obx(() {
              return GridView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: AppSize.s16,
                  mainAxisSpacing: AppSize.s16,
                  childAspectRatio: 5,
                ),
                itemCount: subTradingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        return SizedBox(
                          width: AppSize.s32,
                          height: AppSize.s32,
                          child: Radio(
                            value: index,
                            activeColor: ColorManager.yellow,
                            groupValue: idSelectList.value,
                            onChanged: (int? value) {
                              idSelectList.value = value!;
                              idTradingList.value = subTradingList[index].id;
                            },
                          ),
                        );
                      }),
                      const SizedBox(width: AppSize.s16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(subTradingList[index].persianName,
                              style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: AppSize.s12)),
                          Text(
                              subTradingList[index].name, style: getMediumStyle(
                              color: ColorManager.black.withOpacity(0.8),
                              fontSize: AppSize.s10)),
                        ],
                      )
                    ],
                  );
                },
              );
            }),
          ),
        );
      },
    );
  }

  // dialog group list
  void dialogMainCategoryList(context, List list) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
          width: MediaQuery
              .of(context)
              .size
              .height / 2,
          height: MediaQuery
              .of(context)
              .size
              .height / 4,
          column: Obx(() {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    idMainCategoryList.value = mainCategoryList[index].id;
                    nameMainCategoryList.value =
                        mainCategoryList[index].persianName;
                    nameCategoryList.value = 'انتخاب کنید';
                    nameSubCategoryList.value = [];
                    nameSubCategoryListString.value = 'انتخاب کنید';
                    idCategoryList.value = 0;
                    idSubCategoryList.value = [];

                    // nameCompanyList.value = [];
                    // nameCompanyListString.value = 'انتخاب کنید';
                    // idCompanyList.value = [];

                    GoRouter.of(context).pop();
                  },
                  child: SizedBox(
                    height: AppSize.s40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(list[index].persianName,
                        style: getMediumStyle(
                            color: ColorManager.black, fontSize: AppSize.s14),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
  void dialogCategoryList(context, List list) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
          width: MediaQuery
              .of(context)
              .size
              .height / 2,
          height: MediaQuery
              .of(context)
              .size
              .height / 4,
          column: Obx(() {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    idCategoryList.value = categoryList[index].id;
                    nameCategoryList.value = categoryList[index].persianName;
                    nameSubCategoryList.value = [];
                    nameSubCategoryListString.value = 'انتخاب کنید';
                    idSubCategoryList.value = [];

                    // nameCompanyList.value = [];
                    // nameCompanyListString.value = 'انتخاب کنید';
                    // idCompanyList.value = [];
                    GoRouter.of(context).pop();
                  },
                  child: SizedBox(
                    height: AppSize.s40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(list[index].persianName,
                        style: getMediumStyle(
                            color: ColorManager.black, fontSize: AppSize.s14),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
  void dialogSubCategoryList(context, List list) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
            width: MediaQuery
                .of(context)
                .size
                .height / 2,
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            column: Column(
              children: [
                Obx(() {
                  return Expanded(child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      SubGroup item = list[index];
                      final isSelected = false.obs;
                      isSelected.value = item.id != item.id;
                      isSelected.value = containsIdInList(idSubCategoryList, item.id);
                      return Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(AppSize.s8),
                          child: ItemListSubCategury(
                            onTapCheckBoxAll: () {
                              isSelected.value = !isSelected.value;
                              if (isSelected.value) {
                                idSubCategoryList.add(subCategoryList[index].id.toString());
                                nameSubCategoryList.add(subCategoryList[index].persianName);
                              } else {
                                idSubCategoryList.remove(subCategoryList[index].id.toString());
                                nameSubCategoryList.remove(subCategoryList[index].persianName);
                              }

                              // if(isSelected.value == true){
                              //   idUser.add(item.id);
                              // }else{
                              //   idUser.remove(item.id);
                              // }
                            },
                            name: list[index].persianName,
                            itemsActive: isSelected.value,
                          ),
                        );
                      });
                    },
                  ));
                }),
                const SizedBox(height: AppSize.s24),
                Btn(
                  buttonColorBtn: ColorManager.yellow,
                  onPress: () {
                    nameSubCategoryListString.value = nameSubCategoryList.join(', ');
                    GoRouter.of(context).pop();
                  },
                  text: 'افزودن',
                  heightBtn: AppSize.s48,
                  borderRadiusBtn: AppSize.s8,
                  buttonTextColorBtn: ColorManager.black,
                  borderSideColorBtn: ColorManager.yellow,
                ),
              ],
            )
        );
      },
    );
  }
  void dialogCompanyList(context, List list) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
            width: MediaQuery
                .of(context)
                .size
                .height / 2,
            height: MediaQuery
                .of(context)
                .size
                .height / 2,
            column: Column(
              children: [
                Obx(() {
                  return Expanded(child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      Company item = list[index];
                      final isSelected = false.obs;
                      isSelected.value = item.id != item.id;
                      isSelected.value = containsIdInList(idCompanyList, item.id);
                      return Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(AppSize.s8),
                          child: ItemListSubCategury(
                            onTapCheckBoxAll: () {
                              isSelected.value = !isSelected.value;
                              if (isSelected.value) {
                                idCompanyList.add(companyList[index].id.toString());
                                nameCompanyList.add(companyList[index].persianName);
                              } else {
                                idCompanyList.remove(companyList[index].id.toString());
                                nameCompanyList.remove(companyList[index].persianName);
                              }
                              // if(isSelected.value == true){
                              //   idUser.add(item.id);
                              // }else{
                              //   idUser.remove(item.id);
                              // }
                            },
                            name: list[index].persianName,
                            itemsActive: isSelected.value,
                          ),
                        );
                      });
                    },
                  ));
                }),
                const SizedBox(height: AppSize.s24),
                Btn(
                  buttonColorBtn: ColorManager.yellow,
                  onPress: () {
                    nameCompanyListString.value = nameCompanyList.join(', ');
                    GoRouter.of(context).pop();
                  },
                  text: 'افزودن',
                  heightBtn: AppSize.s48,
                  borderRadiusBtn: AppSize.s8,
                  buttonTextColorBtn: ColorManager.black,
                  borderSideColorBtn: ColorManager.yellow,
                ),
              ],
            )
        );
      },
    );
  }

  // edite list
  void fetchMainGroupEdit(id) {
    final mainGroup = MyPreferences
        .getMainGroup()
        .values
        .toList();
    final mainGroupList = mainGroup.map((item) => MainGroup.fromJson(item))
        .toList();
    mainCategoryList.assignAll(mainGroupList);
    // mainCategoryList.add(MainGroup(
    //     icon: null, description: '', id: 0, persianName: AppString.all));
    mainCategoryList.sort((a, b) => a.id.compareTo(b.id));

    MainGroup? foundItem = mainCategoryList.firstWhere((item) => item.id == id);
    nameMainCategoryList.value = foundItem.persianName.toString();
    idMainCategoryList.value = foundItem.id;
  }
  void fetchGroupEdit(id) {
    final group = MyPreferences
        .getGroup()
        .values
        .toList();
    final groupList = group.map((item) => Group.fromJson(item)).toList();
    categoryList.assignAll(groupList);
    // categoryList.add(
    //     Group(description: '', id: 0, persianName: AppString.all, parentId: 0));
    categoryList.sort((a, b) => a.id.compareTo(b.id));

    Group? foundItem = categoryList.firstWhere(
          (item) => item.id == id,
    );
    nameCategoryList.value = foundItem.persianName.toString();
    idCategoryList.value = foundItem.id;
  }
  void fetchSubCategoryEdit(id) {
    final subGroup = MyPreferences.getSubGroup().values.toList();
    final subGroupList = subGroup.map((item) => SubGroup.fromJson(item)).toList();
    subCategoryList.assignAll(subGroupList);
    // subCategoryList.add(SubGroup(description: '', id: 0, persianName: AppString.all, parentId: 0));
    subCategoryList.sort((a, b) => a.id.compareTo(b.id));

    // SubGroup? foundItem = subCategoryList.firstWhere((item) => item.id == id);
    // nameSubCategoryList.value = [foundItem.persianName.toString()];
    // idSubCategoryList.value = [foundItem.id];

    var splitSubGroup = id.split(', ');
    for (var i = 0; i < splitSubGroup!.length; i++) {
      var subGroupList = GetDateGroupApi().findSubGroupById(splitSubGroup[i]);
      nameSubCategoryList.add(subGroupList.persianName);
    }
    nameSubCategoryListString.value = nameSubCategoryList.join(',');
    idSubCategoryList.value = splitSubGroup;
  }
  void fetchTradingHallEdit(id) {
    final mainGroup = MyPreferences
        .getTradingHall()
        .values
        .toList();
    final mainGroupList = mainGroup.map((item) => TradingHall.fromJson(item))
        .toList();
    subTradingList.assignAll(mainGroupList);
    // subTradingList.add(TradingHall(id: 0, persianName: AppString.all, name: ''));

    TradingHall? foundItem = subTradingList.firstWhere(
          (item) => item.id == id,
    );
    idTradingList.value = foundItem.id;
  }
  void fetchCompanyEdit(id) {
    final subGroup = MyPreferences.getCompany().values.toList();
    final subGroupList = subGroup.map((item) => Company.fromJson(item)).toList();
    companyList.assignAll(subGroupList);
    // subCategoryList.add(SubGroup(description: '', id: 0, persianName: AppString.all, parentId: 0));
    companyList.sort((a, b) => a.id.compareTo(b.id));

    // SubGroup? foundItem = subCategoryList.firstWhere((item) => item.id == id);
    // nameSubCategoryList.value = [foundItem.persianName.toString()];
    // idSubCategoryList.value = [foundItem.id];

    var splitSubGroup = id.split(', ');
    for (var i = 0; i < splitSubGroup!.length; i++) {
      var subGroupList = GetDateGroupApi().findCompanyById(splitSubGroup[i]);
      nameCompanyList.add(subGroupList.persianName);
    }
    nameCompanyListString.value = nameCompanyList.join(',');
    idCompanyList.value = splitSubGroup;
  }

  // get list
  void fetchCategoryList() async {
    final mainGroup = MyPreferences
        .getMainGroup()
        .values
        .toList();
    final mainGroupList = mainGroup.map((item) => MainGroup.fromJson(item))
        .toList();
    mainCategoryList.assignAll(mainGroupList);
    // mainCategoryList.add(MainGroup(
    //     icon: null, description: '', id: 0, persianName: AppString.all));
    mainCategoryList.sort((a, b) => a.id.compareTo(b.id));
  }
  void fetchMainCategoryList(int mainCategoryId) async {
    final group = MyPreferences
        .getGroup()
        .values
        .toList();
    final groupList = group.map((item) => Group.fromJson(item)).toList();
    categoryList.assignAll(
        groupList.where((item) => item.parentId == mainCategoryId).toList());
    // categoryList.add(
    //     Group(parentId: 0, description: '', id: 0, persianName: AppString.all));
    categoryList.sort((a, b) => a.id.compareTo(b.id));
  }
  void fetchSubCategoryList(subCategoryId) async {
    final subGroup = MyPreferences.getSubGroup().values.toList();
    final subGroupList = subGroup.map((item) => SubGroup.fromJson(item))
        .toList();
    subCategoryList.assignAll(subGroupList.where((item) => item.parentId == subCategoryId).toList());
    // subCategoryList.add(SubGroup(
    //     parentId: 0, description: '', id: 0, persianName: AppString.all));
    subCategoryList.sort((a, b) => a.id.compareTo(b.id));
  }
  void fetchTradingHallList() async {
    final mainGroup = MyPreferences
        .getTradingHall()
        .values
        .toList();
    final mainGroupList = mainGroup.map((item) => TradingHall.fromJson(item))
        .toList();
    subTradingList.assignAll(mainGroupList);
    subTradingList.sort((a, b) => a.id.compareTo(b.id));
  }
  void fetchCompanyList() async {
    final companyGroup = MyPreferences.getCompany().values.toList();
    final companyGroupList = companyGroup.map((item) => Company.fromJson(item)).toList();
    companyList.assignAll(companyGroupList);
    // mainCategoryList.add(MainGroup(
    //     icon: null, description: '', id: 0, persianName: AppString.all));
    // companyList.sort((a, b) => a.id.compareTo(b.id));
  }

  int getIndexById(List<TradingHall> list, int targetId) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == targetId) {
        return i;
      }
    }
    return -1; // Return -1 if ID is not found
  }
  bool containsIdInList(List idList, int targetId) {
    return idList.any((id) => int.parse(id) == targetId);
  }
  String fetchSubCategoryEditGroup(id) {
    final subGroup = MyPreferences.getSubGroup().values.toList();
    final subGroupList = subGroup.map((item) => SubGroup.fromJson(item)).toList();
    subCategoryList.assignAll(subGroupList);
    // subCategoryList.add(SubGroup(description: '', id: 0, persianName: AppString.all, parentId: 0));
    subCategoryList.sort((a, b) => a.id.compareTo(b.id));

    // SubGroup? foundItem = subCategoryList.firstWhere((item) => item.id == id);
    // nameSubCategoryList.value = [foundItem.persianName.toString()];
    // idSubCategoryList.value = [foundItem.id];

    var splitSubGroup = id.split(', ');
    nameSubCategoryList.clear();
    for (var i = 0; i < splitSubGroup!.length; i++) {
      var subGroupList = GetDateGroupApi().findSubGroupById(splitSubGroup[i]);
      nameSubCategoryList.add(subGroupList.persianName);
    }
    return nameSubCategoryList.join(', ');
  }
  String fetchCompanyEditGroup(id) {
    final subGroup = MyPreferences.getCompany().values.toList();
    final subGroupList = subGroup.map((item) => Company.fromJson(item)).toList();
    companyList.assignAll(subGroupList);
    // subCategoryList.add(SubGroup(description: '', id: 0, persianName: AppString.all, parentId: 0));
    companyList.sort((a, b) => a.id.compareTo(b.id));

    var companyGroup = id.split(', ');
    nameCompanyList.clear();
    for (var i = 0; i < companyGroup.length; i++) {
      var subGroupList = GetDateGroupApi().findCompanyById(companyGroup[i]);
      nameCompanyList.add(subGroupList.persianName);
    }
    return nameCompanyList.join(', ');
  }


  void dialogAddListUser(id,context) {
    showDialog(
      context: context,
      builder: (context) {
        return WidgetDialogList(
            width: MediaQuery
                .of(context)
                .size
                .width / 2,
            height: MediaQuery
                .of(context)
                .size
                .height / 1.5,
            column: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'اضافه کردن کاربران جدید',
                      style: getBoldStyle(
                          color: ColorManager.black, fontSize: AppSize.s18),
                    ),
                    InkWell(
                      onTap: ()=> Navigator.of(context).pop(),
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
                  ],
                ),
                const SizedBox(height: AppSize.s24),
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      itemCount: addMemberLogic.listUser.length,
                      itemBuilder: (context, index) {
                        final isAddSelected = false.obs;
                        ModelUser item = addMemberLogic.listUser[index];
                        isAddSelected.value = item.id != item.id;
                        return Obx(() {
                          return ItemListUser(
                            activeCheckBox: true,
                            itemsActive: isAddSelected.value,
                            activeEditItem: false,
                            itemsUserName: addMemberLogic.listUser[index].name,
                            itemsUserFamily: addMemberLogic.listUser[index].family,
                            itemsUserPhone: addMemberLogic.listUser[index].phone,
                            itemsIndex: index,
                            onPressDeleteItem: null,
                            onPressEditeItem: null,
                            onTap: () {
                              // idTradingList.value = item.id;
                              isAddSelected.value = !isAddSelected.value;
                              if (isAddSelected.value == true) {
                                addIdUser.add(item.id);
                              } else {
                                addIdUser.remove(item.id);
                              }
                            },
                          );
                        });
                      },
                    );
                  }),
                ),
                const SizedBox(height: AppSize.s24),
                Btn(
                  buttonColorBtn: ColorManager.yellow,
                  onPress: () {
                    addUserGroupRequest(id,context);
                  },
                  text: 'افزودن',
                  heightBtn: AppSize.s48,
                  borderRadiusBtn: AppSize.s8,
                  buttonTextColorBtn: ColorManager.black,
                  borderSideColorBtn: ColorManager.yellow,
                ),
              ],
            )
        );
      },
    );
  }
  void addUserGroupRequest(id, context) {
    String result = addIdUser.join(', ');
    addUserGroup(context, id: id, data: {
      'users': result,
    });
  }
  Future<void> addUserGroup(context, {Map<String, dynamic>? data, id}) async {
    try {
      final response = await apiServicePanel.post(
          url: '${AppUrl.addUserGroup}$id' , data: data, options: Options(headers: {
        "content-Type": "application/json",
        "authorization": "Bearer ${MyPreferences.getToken()}",
      }));
      if (response.statusCode == 201) {
        homeLogic.getPanelRoom(context);
        homeLogic.listUser(id , context);
        addIdUser.clear();
        GoRouter.of(context).pop();
      }else if(response.statusCode == 404){
        Alert(txt: 'کاربر تکراری است', color: ColorManager.white, backgroundColor: ColorManager.red).showSnackBar(context);
      }
    } on DioException catch (e){
      addIdUser.clear();
      Alert(txt: 'خطا در اطلاعات دربافتی',
          color: ColorManager.white,
          backgroundColor: ColorManager.red).showSnackBar(context);
    }
  }

}

