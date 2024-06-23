import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../component/button_component/btn/_btn.dart';
import '../../component/input_component/defult/defulttextfield.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import 'logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Shortcuts(
        shortcuts: const <ShortcutActivator,Intent>{
          SingleActivator(LogicalKeyboardKey.enter) : IncrementIntent(),
        },
        child: Actions(
          actions: {
            IncrementIntent : CallbackAction<IncrementIntent>(
                onInvoke:  (event) => logic.loading.value == true ? null : logic.loginRequest(context),
            )
          },
          child: Focus(
              autofocus: true,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p56),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: AppSize.s300,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                  ImageAssets.splashLogo, height: AppSize.s80,
                                  width: AppSize.s80,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(height: AppSize.s8),
                          SizedBox(
                            width: AppSize.s300,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('خوش آمدید!', style: getBoldStyle(
                                  color: ColorManager.black, fontSize: AppSize.s24)),
                            ),
                          ),
                          const SizedBox(height: AppSize.s8),
                          SizedBox(
                            width: AppSize.s300,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  'برای ورود نام کاربری و رمزعبور خود را وارد کنید',
                                  style: getBoldStyle(color: ColorManager.black
                                      .withOpacity(0.4), fontSize: AppSize.s14)),
                            ),
                          ),
                          const SizedBox(height: AppSize.s24),
                          SizedBox(
                            width: AppSize.s300,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('نام کاربری', style: getBoldStyle(
                                  color: ColorManager.black, fontSize: AppSize.s14)),
                            ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          SizedBox(
                            width: AppSize.s300,
                            child: DefaultTextField(
                              obscureText: false,
                              textFieldColor: ColorManager.white,
                              textInputType: TextInputType.text,
                              borderSideWidth: AppSize.s2,
                              borderSideColor: ColorManager.gray1,
                              hintStyle: getMediumStyle(
                                  color: ColorManager.gray1, fontSize: AppSize.s14),
                              hintText: '',
                              textFieldActive: false,
                              textFieldController: logic.txtUserName,
                              textAlign: TextAlign.right,
                            ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          SizedBox(
                            width: AppSize.s300,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text('رمزعبور', style: getBoldStyle(
                                  color: ColorManager.black, fontSize: AppSize.s14)),
                            ),
                          ),
                          const SizedBox(height: AppSize.s16),
                          SizedBox(
                            width: AppSize.s300,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Obx(() {
                                    return DefaultTextField(
                                      obscureText: logic.eye.value,
                                      textFieldColor: ColorManager.white,
                                      textInputType: TextInputType.text,
                                      borderSideWidth: AppSize.s2,
                                      borderSideColor: ColorManager.gray1,
                                      hintStyle: getMediumStyle(
                                          color: ColorManager.gray1,
                                          fontSize: AppSize.s14),
                                      hintText: '',
                                      textFieldActive: false,
                                      textFieldController: logic.txtPassword,
                                      textAlign: TextAlign.right,
                                    );
                                  }),
                                ),
                                Obx(() {
                                  return IconButton(onPressed: () {
                                    logic.eye.value = !logic.eye.value;
                                  },
                                      icon: !logic.eye.value ? const Icon(
                                          Icons.remove_red_eye) : const Icon(
                                          Icons.remove_red_eye_outlined));
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s24),
                          Obx(() {
                            return SizedBox(
                              width: AppSize.s300,
                              child: Btn(
                                buttonColorBtn: logic.loading.value == true
                                    ? ColorManager.gray1
                                    : ColorManager.yellow,
                                onPress: () =>
                                logic.loading.value == true ? null : logic.loginRequest(context),
                                text: 'ورود به حساب',
                                heightBtn: AppSize.s48,
                                borderRadiusBtn: AppSize.s12,
                                buttonTextColorBtn: ColorManager.black,
                                borderSideColorBtn: logic.loading.value == true
                                    ? ColorManager.gray1
                                    : ColorManager.yellow,
                              ),
                            );
                          }),
                          const SizedBox(height: AppSize.s16),
                          Obx(() {
                            return Visibility(
                              visible: logic.loading.value,
                              child: CircularProgressIndicator(
                                color: ColorManager.black, //<-- SEE HERE
                              ),
                            );
                          })

                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      child: Image.asset(
                          ImageAssets.imgBackground, fit: BoxFit.scaleDown),
                    ),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}

class IncrementIntent extends Intent{
  const IncrementIntent();
}


