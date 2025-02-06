import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../dataurl/data/model/grouplistmodel.dart';
import '../../../dataurl/data/model/trading-hall-model.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import '../button_component/select-btn/select-bn.dart';

class GroupListItem extends StatelessWidget {
  final int index;
  final TradingHall tradingHall;
  final GroupList group;
  final bool active;

  final VoidCallback onPressUpdate;

  const GroupListItem({
    super.key,
    required this.index,
    required this.tradingHall,
    required this.group,
    required this.active,
    required this.onPressUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: AppSize.s48,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${index + 1}',
                style: getMediumStyle(color: ColorManager.black, fontSize: AppSize.s14),
              ),
              const SizedBox(width: AppSize.s24),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSize.s8,
                      height: AppSize.s8,
                      decoration: BoxDecoration(
                        color: ColorManager.yellow,
                        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s2)),
                      ),
                    ),
                    const SizedBox(width: AppSize.s8),
                    Text(
                      ' نوع بازار : ${tradingHall.persianName}',
                      style: getMediumStyle(color: ColorManager.black.withOpacity(0.6), fontSize: AppSize.s14),
                    ),
                  ],
                )
              ),
              Expanded(
                child: Text(
                  'نام : ${group.name}',
                  style: getMediumStyle(color: ColorManager.black.withOpacity(0.6), fontSize: AppSize.s14),
                ),
              ),
              active ?
              Expanded(
                child: Text(
                  'زمان ارسال پیامک : ساعت ${group.cronJobTime}',
                  style: getMediumStyle(color: ColorManager.black, fontSize: AppSize.s14),
                ),
              ) :
              Expanded(
                child: Text(
                  'تاریخ جست و جو عرضه : ${group.cronJobFutureDays} روز بعد ',
                  style: getMediumStyle(color: ColorManager.black, fontSize: AppSize.s14),
                ),
              ),
              SelectBtn(
                appPaddingSelect: AppPadding.p0,
                appSizeBtn: AppSize.s14,
                mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
                visibleSelect: false,
                iconSelect: SvgPicture.asset(ImageAssets.edit,width: AppSize.s24,height: AppSize.s24),
                onPress: onPressUpdate,
                text: 'ویرایش',
                borderColor: ColorManager.white,
                radius: AppSize.s0,
                heightBtn: AppSize.s48,
                colorTextSelect: ColorManager.black.withOpacity(0.6),
                backgroundColorSelect: ColorManager.white,
              ),
              const SizedBox(width: AppSize.s24),
            ],
          ),
        ),
        Divider(color: ColorManager.gray, height: AppSize.s05),
      ],
    );
  }
}
