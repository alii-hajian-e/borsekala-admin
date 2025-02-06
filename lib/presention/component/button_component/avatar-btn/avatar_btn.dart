// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../org-btn/wid_button.dart';

class AvatarBtn extends WidgetAvatarButton {

  final String nameKargozari;

  final String imageAvatar;
  final double widthBorderAvatar;
  final Color buttonColorAvatar;
  final double borderRadiusAvatar;
  final Color borderSideColorAvatar;
  final double heightAvatarButtonAvatar;
  final double widthAvatarButtonAvatar;


  const AvatarBtn( {
    super.key,
    required this.nameKargozari,
    required this.imageAvatar,
    required this.widthBorderAvatar,
    required this.buttonColorAvatar,
    required this.borderRadiusAvatar,
    required this.borderSideColorAvatar,
    required this.heightAvatarButtonAvatar,
    required this.widthAvatarButtonAvatar,

  }):
        super(
        image: imageAvatar,
        widthBorder: widthBorderAvatar,
        buttonColor: buttonColorAvatar,
        borderRadius: borderRadiusAvatar,
        borderSideColor: borderSideColorAvatar,
        heightAvatarButton: heightAvatarButtonAvatar,
        widthAvatarButton: widthAvatarButtonAvatar,
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WidgetAvatarButton(
          heightAvatarButton: heightAvatarButtonAvatar,
          widthAvatarButton: widthAvatarButtonAvatar,
          buttonColor: buttonColorAvatar,
          borderRadius: borderRadiusAvatar,
          borderSideColor: borderSideColorAvatar,
          widthBorder: widthBorderAvatar,
          image: imageAvatar,
        ),
        const SizedBox(width: AppSize.s16),
        Text(nameKargozari,style: getBoldStyle(color: ColorManager.black,fontSize: AppSize.s16))
      ],
    );
  }
}