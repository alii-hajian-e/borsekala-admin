import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/value_manager.dart';
import '../button_component/select-btn/select-bn.dart';
import '../input_component/search_bar/search_component.dart';

class HeaderBar extends StatelessWidget {
  final TextEditingController textFieldController;
  final dynamic onPress;
  final dynamic onChanged;
  final String nameBtn;
  final bool visible;
  final IconData icon;

  const HeaderBar(
      {super.key, required this.textFieldController, this.onPress, required this.nameBtn, required this.icon, this.onChanged, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        color: ColorManager.gray.withOpacity(0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: AppSize.s260,
            child: SearchWidget(
              textFieldBorderSearch: BorderSide(
                  width: AppSize.s0, color: ColorManager.white),
              textFieldColor: ColorManager.gray1,
              textInputType: TextInputType.text,
              textFieldActive: false,
              prefixIcon: SvgPicture.asset(fit: BoxFit.scaleDown,ImageAssets.search,width: AppSize.s16,height: AppSize.s16,),
              textFieldHint: 'جست و جو',
              textFieldController: textFieldController,
              onChanged: onChanged,
            ),
          ),
          Visibility(
            visible: visible,
            child: SelectBtn(
              appPaddingSelect: AppPadding.p16,
              appSizeBtn: AppSize.s14,
              mainAxisAlignmentSelect: MainAxisAlignment.spaceBetween,
              visibleSelect: false,
              iconSelect: Icon(
                  icon, color: ColorManager.black, size: AppSize.s18),
              onPress: onPress,
              text: nameBtn,
              borderColor: ColorManager.white.withOpacity(0),
              radius: AppSize.s8,
              heightBtn: AppSize.s48,
              colorTextSelect: ColorManager.black,
              backgroundColorSelect: ColorManager.gray1,
            ),
          ),
        ],
      ),
    );
  }
}