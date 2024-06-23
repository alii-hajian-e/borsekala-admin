
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../button_component/select-btn/select-bn.dart';

class ItemListCategory extends StatelessWidget {
  final bool visibleBtn;
  final bool visibleBtnSms;
  final bool visibleEdit;
  final String nameGroup;
  final String time;
  final String name;
  final String num;
  final String mainCategory;
  final String grouping;
  final String subset;
  final String manufacturer;
  final dynamic onPressBtnEdit;
  final dynamic onPressBtnDelete;
  final dynamic onPressBtn;
  final dynamic onPressBtnSms;
  final dynamic onTapGroup;

  const ItemListCategory({super.key, required this.visibleBtn, required this.visibleEdit, required this.name, required this.num, required this.mainCategory, required this.grouping, required this.subset, required this.manufacturer, required this.nameGroup, required this.time, this.onPressBtnEdit, this.onPressBtnDelete, this.onPressBtn, this.onTapGroup, required this.visibleBtnSms, required this.onPressBtnSms});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapGroup,
      child: Container(
          padding: const EdgeInsets.all(AppPadding.p24),
          decoration: BoxDecoration(
            color: ColorManager.gray.withOpacity(0.7),
            borderRadius: BorderRadius.circular(AppSize.s16),
            border: Border.all(color: ColorManager.gray1,width: AppSize.s2)
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: AppSize.s8,
                            height: AppSize.s8,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(AppSize.s32)),
                                color: ColorManager.yellow
                            ),
                          ),
                          const SizedBox(width: AppSize.s16),
                          Text(nameGroup,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                        ],
                      ),
                      const SizedBox(height: AppSize.s8),
                      Text(time,style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
                    ],
                  ),
                  Visibility(
                    visible: visibleEdit,
                    child: Row(
                      children: [
                        SelectBtn(
                          appPaddingSelect: AppPadding.p0,
                          appSizeBtn: AppSize.s12,
                          mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                          visibleSelect: false,
                          iconSelect: SvgPicture.asset(ImageAssets.edit,width: AppSize.s24,height: AppSize.s24),
                          onPress: onPressBtnEdit,
                          text: 'ویرایش',
                          borderColor: ColorManager.white.withOpacity(0),
                          radius: AppSize.s0,
                          heightBtn: AppSize.s24,
                          colorTextSelect:  ColorManager.black.withOpacity(0.4),
                          backgroundColorSelect: ColorManager.white.withOpacity(0),
                        ),
                        const SizedBox(width: AppSize.s16),
                        SelectBtn(
                          appPaddingSelect: AppPadding.p0,
                          appSizeBtn: AppSize.s12,
                          mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                          visibleSelect: false,
                          iconSelect: SvgPicture.asset(ImageAssets.trash,width: AppSize.s24,height: AppSize.s24),
                          onPress: onPressBtnDelete,
                          text: 'حذف',
                          borderColor: ColorManager.white.withOpacity(0),
                          radius: AppSize.s0,
                          heightBtn: AppSize.s24,
                          colorTextSelect: ColorManager.red,
                          backgroundColorSelect: ColorManager.white.withOpacity(0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s24),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text('نام:',style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
                  ),
                  Expanded(child: Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Text(name,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text('تعداد کاربر ها:',style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
                  ),
                  Expanded(child: Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Text(num,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text('دسته بندی اصلی:',style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
                  ),
                  Expanded(child: Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Text(mainCategory,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text('دسته بندی:',style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
                  ),
                  Expanded(child: Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Text(grouping,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14)),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
              //       child: Text('زیر دسته بندی:',style: getBoldStyle(color: ColorManager.black.withOpacity(0.4),fontSize: AppSize.s12)),
              //     ),
              //     Expanded(child: Divider(height: AppSize.s1,color: ColorManager.black.withOpacity(0.4))),
              //     Padding(
              //       padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
              //       child: Text(subset,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s14),overflow: TextOverflow.clip,textAlign: TextAlign.left),
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text(
                      'زیر دسته بندی:',
                      style: getBoldStyle(color: ColorManager.black.withOpacity(0.4), fontSize: AppSize.s12),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: AppSize.s1,
                      color: ColorManager.black.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(width: AppSize.s8),
                  Expanded(
                    // padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subset,
                        style: getBoldStyle(color: ColorManager.black, fontSize: AppSize.s14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: Text(
                      'شرکت :',
                      style: getBoldStyle(color: ColorManager.black.withOpacity(0.4), fontSize: AppSize.s12),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      height: AppSize.s1,
                      color: ColorManager.black.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(width: AppSize.s8),
                  Expanded(
                    // padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        manufacturer,
                        style: getBoldStyle(color: ColorManager.black, fontSize: AppSize.s14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s16),

              Visibility(
                visible: visibleBtn,
                child: SelectBtn(
                  appPaddingSelect: AppPadding.p0,
                  appSizeBtn: AppSize.s14,
                  mainAxisAlignmentSelect: MainAxisAlignment.center,
                  visibleSelect: false,
                  iconSelect: Icon(Icons.person_outline,color: ColorManager.black,size: AppSize.s18),
                  onPress: onPressBtn,
                  text: 'ویرایش کاربر',
                  borderColor: ColorManager.gray1,
                  radius: AppSize.s8,
                  heightBtn: AppSize.s48,
                  colorTextSelect: ColorManager.black,
                  backgroundColorSelect: ColorManager.gray1,
                ),
              ),
              Visibility(
                visible: visibleBtnSms,
                child: SelectBtn(
                  appPaddingSelect: AppPadding.p0,
                  appSizeBtn: AppSize.s14,
                  mainAxisAlignmentSelect: MainAxisAlignment.center,
                  visibleSelect: false,
                  iconSelect: Icon(Icons.sms_outlined,color: ColorManager.black,size: AppSize.s18),
                  onPress: onPressBtnSms,
                  text: 'ارسال پیامک تستی',
                  borderColor: ColorManager.gray1,
                  radius: AppSize.s8,
                  heightBtn: AppSize.s48,
                  colorTextSelect: ColorManager.black,
                  backgroundColorSelect: ColorManager.gray1,
                ),
              ),
            ],
          )
      ),
    );
  }
}
