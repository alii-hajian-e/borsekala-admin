// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';

class WidgetButton extends StatelessWidget {
  final buttonOnPressed;
  final Color buttonColor;
  final Color buttonTextColor;
  final buttonText;
  //final buttonMargin;

  final height;
  final fontSize;
  final borderRadius;
  final borderSideColor;

  const WidgetButton({
    super.key,

    required this.buttonTextColor,
    //required this.buttonMargin,
    required this.buttonOnPressed,
    required this.buttonColor,
    required this.buttonText,
    required this.height,
    required this.fontSize,
    required this.borderRadius,
    required this.borderSideColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      //margin: buttonMargin,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: borderSideColor, width: 1.0),
            backgroundColor: buttonColor, //specify the button's elevation color
            elevation: 0, //buttons Material shadow
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    borderRadius)), // set the buttons shape. Make its birders rounded etc
          ),
          onPressed: buttonOnPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
            child: Center(
              child: Text(
                buttonText,
                style: getBoldStyle(color: buttonTextColor, fontSize: fontSize),
              ),
            ),
          )),
    );
  }
}
class WidgetButtonCircle extends StatelessWidget {
  final buttonOnPressed;
  final Color buttonColor;
  final icon;

  const WidgetButtonCircle({
    super.key,

    required this.buttonOnPressed,
    required this.buttonColor,
    required this.icon,

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: buttonOnPressed,
      autofocus: false,
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(AppSize.s100),
        ),
        child: icon,
      ),
    );
  }
}
class WidgetButtonSelect extends StatelessWidget {
  final buttonOnPressed;
  final Color colorText;
  final height;
  final appSize;
  final dynamic icon;
  final String txt;
  final double borderRadius;
  final double appPadding;
  final borderSideColor;
  final Color backgroundColor;
  final mainAxisAlignment;
  final visible;

  const WidgetButtonSelect({
    super.key,

    required this.buttonOnPressed,
    required this.height,
    required this.appPadding,
    required this.appSize,
    required this.icon,
    required this.colorText,
    required this.txt,
    required this.borderRadius,
    required this.borderSideColor,
    required this.backgroundColor,
    required this.mainAxisAlignment,
    required this.visible

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: buttonOnPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(color: borderSideColor,width: AppSize.s2),
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !visible,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: icon,
                  ),
                ),
                Text(txt,
                  style: getMediumStyle(
                    color: colorText,
                    fontSize: appSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                Visibility(
                  visible: visible,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: icon,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
class WidgetAvatarButton extends StatelessWidget {

  final double heightAvatarButton;
  final double widthAvatarButton;
  final Color buttonColor;
  final double borderRadius;
  final Color borderSideColor;
  final double widthBorder;
  final String image;

  const WidgetAvatarButton({
    super.key,
    required this.heightAvatarButton,
    required this.widthAvatarButton,
    required this.buttonColor,
    required this.borderRadius,
    required this.borderSideColor,
    required this.widthBorder,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightAvatarButton,
      width: widthAvatarButton,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderSideColor,width: widthBorder)
      ),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)
            ),
          ),
        )
      ),

    );
  }
}

class WidgetButtonSelectVersionNew extends StatelessWidget {
  final buttonOnPressed;
  final Color colorText;
  final height;
  final appSize;
  final dynamic icon;
  final String txt;
  final double borderRadius;
  final double appPadding;
  final borderSideColor;
  final Color backgroundColor;
  final mainAxisAlignment;
  final visible;

  const WidgetButtonSelectVersionNew({
    super.key,

    required this.buttonOnPressed,
    required this.height,
    required this.appPadding,
    required this.appSize,
    required this.icon,
    required this.colorText,
    required this.txt,
    required this.borderRadius,
    required this.borderSideColor,
    required this.backgroundColor,
    required this.mainAxisAlignment,
    required this.visible

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: buttonOnPressed,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: appPadding),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              border: Border.all(color: borderSideColor,width: AppSize.s2),
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !visible,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p8, AppPadding.p0, AppPadding.p0, AppPadding.p0),
                    child: icon,
                  ),
                ),
                SizedBox(
                  width: AppSize.s200,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(txt,
                      style: getMediumStyle(
                        color: colorText,
                        fontSize: appSize,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  )
                ),
                Visibility(
                  visible: visible,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(AppPadding.p0, AppPadding.p0, AppPadding.p8, AppPadding.p0),
                    child: icon,
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}

