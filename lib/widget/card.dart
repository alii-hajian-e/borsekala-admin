import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:bors_web_admin_sms/presention/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../presention/resources/styles_manager.dart';

class CardView extends StatelessWidget {
  final String? image;
  final double? widthImage;
  final double? heightImage;
  final String? txtTitle;
  final String? txtCount;

  const CardView({super.key, this.image, this.widthImage, this.heightImage, this.txtTitle, this.txtCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s160,
      padding: const EdgeInsets.all(AppPadding.p24),
      decoration: BoxDecoration(
        color: ColorManager.gray,
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
        border: Border.all(color: ColorManager.black.withOpacity(0.4),width: AppSize.s1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            image ?? '',
            width: widthImage ?? 0.0,
            height: heightImage ?? 0.0,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(ColorManager.black, BlendMode.srcIn),
          ),
          const SizedBox(height: AppSize.s8),
          Text(txtTitle ?? '',style: getMediumStyle(color: ColorManager.black.withOpacity(0.6),fontSize: AppSize.s14),textAlign: TextAlign.center),
          const SizedBox(height: AppSize.s16),
          Text(txtCount ?? '',style: getBoldStyle(color: ColorManager.black.withOpacity(0.6),fontSize: AppSize.s18),textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
