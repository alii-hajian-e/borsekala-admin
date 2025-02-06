import 'package:bors_web_admin_sms/presention/component/button_component/btn/_btn.dart';
import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/styles_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class Wallet extends StatelessWidget {

  final String? txt;
  final String? price;
  final String? txtButton;
  final String? image;
  final double? widthImage;
  final double? heightImage;
  final VoidCallback onPress;
  final bool? visibleBtn;

  const Wallet({super.key, required this.image, required this.widthImage, required this.heightImage, required this.txt, required this.txtButton, required this.onPress, this.price, required this.visibleBtn});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s100,
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        color: ColorManager.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                image ?? '',
                width: widthImage ?? 0.0,
                height: heightImage ?? 0.0,
                fit: BoxFit.scaleDown,
                colorFilter: ColorFilter.mode(ColorManager.white.withValues(alpha: 0.8), BlendMode.srcIn),
              ),
              const SizedBox(width: AppSize.s8),
              Text(txt ?? '',style: getMediumStyle(color: ColorManager.white.withValues(alpha: 0.8),fontSize: AppSize.s12),textAlign: TextAlign.start),
            ],
          ),
          Text(price ?? '',style: getBoldStyle(color: ColorManager.white,fontSize: AppSize.s18),textAlign: TextAlign.end,maxLines: 1,overflow: TextOverflow.ellipsis),
          Visibility(
            visible: visibleBtn ?? false,
            child: Btn(
              buttonColorBtn: ColorManager.yellow,
              onPress: onPress,
              text: txtButton ?? '',
              heightBtn: AppSize.s48,
              borderRadiusBtn: AppSize.s8,
              buttonTextColorBtn: ColorManager.black,
              borderSideColorBtn: ColorManager.black.withValues(alpha: 0.0),
            ),
          )
        ],
      )
    );
  }
}
