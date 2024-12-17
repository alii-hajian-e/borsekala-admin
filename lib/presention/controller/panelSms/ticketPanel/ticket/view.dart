import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../component/button_component/circle-btn/circle_btn.dart';
import '../../../../component/header_component/header_component.dart';
import '../../../../component/input_component/defult/defulttextfield.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/value_manager.dart';
import 'logic.dart';

class TicketPage extends StatelessWidget {
  TicketPage({super.key});

  final logic = Get.put(TicketLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: logic.scaffoldPanelKey,
      backgroundColor: ColorManager.white,
      endDrawer: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(AppSize.s16)),
        child: Drawer(
          width: MediaQuery
              .of(context)
              .size
              .width / 2,
          shape: Border.all(color: ColorManager.gray1, width: AppSize.s2),
          child: Container(
            color: ColorManager.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pop(),
                        child: Row(
                          children: [
                            Container(
                              width: AppSize.s32,
                              height: AppSize.s32,
                              decoration: BoxDecoration(
                                color: ColorManager.gray,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                              ),
                              child: CircleButton(
                                appSize: AppSize.s8,
                                widthCircle: AppSize.s32,
                                heightCircle: AppSize.s32,
                                buttonColorCircle: ColorManager.gray
                                    .withOpacity(0.0),
                                onPress: null,
                                icons: const Icon(
                                    Icons.clear, size: AppSize.s18),
                                colors: ColorManager.gray,
                                bordersSide: AppSize.s2,
                                borderSideColors: ColorManager.gray,
                              ),
                            ),
                            const SizedBox(width: AppSize.s16),
                            Text(
                              'بستن',
                              style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: AppSize.s14),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        return Text(
                          logic.nameTicket.value.toString(),
                          style: getBoldStyle(
                              color: ColorManager.black, fontSize: AppSize.s18),
                        );
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppMargin.m24),
                    decoration: BoxDecoration(
                      color: ColorManager.gray,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppSize.s16)),
                      border: Border.all(
                          color: ColorManager.gray1, width: AppSize.s2),
                    ),
                    child: Obx(() {
                      if (logic.ticketsChatList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        controller: logic.scrollController,
                        itemCount: logic.responsesTicketChat.length,
                        itemBuilder: (BuildContext context, int index) {
                          DateTime dateTime = DateTime.parse(
                              logic.responsesTicketChat[index].createdAt);
                          final response = logic.responsesTicketChat[index];
                          return Align(
                            alignment: response.sender == 2
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: const EdgeInsets.all(AppPadding.p8),
                              margin: const EdgeInsets.symmetric(
                                  vertical: AppMargin.m4,
                                  horizontal: AppMargin.m8),
                              decoration: BoxDecoration(
                                color: response.sender == 2 ? Colors
                                    .yellow : Colors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(AppSize.s8),
                              ),
                              child: Column(
                                mainAxisAlignment: response.sender == 2
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: response.sender == 2
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    response.sender == 2
                                        ? 'پشتیبانی'
                                        : 'شما',
                                    style: getMediumStyle(
                                        color: ColorManager.black,
                                        fontSize: AppSize.s10),
                                  ),
                                  const SizedBox(height: AppSize.s8),
                                  Text(
                                    response.responseText,
                                    style: getBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: AppSize.s14),
                                  ),
                                  const SizedBox(height: AppSize.s8),
                                  Align(
                                    alignment: response.sender == 2
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      '${dateTime.minute
                                          .toString()} : ${dateTime.hour
                                          .toString()}',
                                      style: getMediumStyle(
                                          color: ColorManager.black,
                                          fontSize: AppSize.s10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSize.s48,
                        height: AppSize.s48,
                        decoration: BoxDecoration(
                          color: ColorManager.yellow,
                          borderRadius: const BorderRadius.all(Radius.circular(
                              AppSize.s8)),
                        ),
                        child: CircleButton(
                          appSize: AppSize.s8,
                          widthCircle: AppSize.s16,
                          heightCircle: AppSize.s16,
                          buttonColorCircle: ColorManager.yellow.withOpacity(
                              0.0),
                          onPress: () {
                            logic.scrollController.animateTo(
                              logic.scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 2000),
                              curve: Curves.easeOut,
                            );
                            logic.sentRequestAddTicketChat(id: logic.idTicket.value , context: context);
                          },
                          icons: SvgPicture.asset(ImageAssets.send,
                            fit: BoxFit.scaleDown, width: 16, height: 16,),
                          colors: ColorManager.yellow,
                          bordersSide: AppSize.s2,
                          borderSideColors: ColorManager.yellow,
                        ),
                      ),
                      const SizedBox(width: AppSize.s16),
                      Expanded(
                        child: DefaultTextField(
                          obscureText: false,
                          textFieldColor: ColorManager.gray,
                          textInputType: TextInputType.text,
                          borderSideWidth: AppSize.s2,
                          borderSideColor: ColorManager.gray,
                          hintStyle: getMediumStyle(color: ColorManager.black
                              .withOpacity(0.6), fontSize: AppSize.s14),
                          hintText: 'چه کمکی از ما بر می آید؟',
                          textFieldActive: false,
                          textFieldController: logic.txtChatTicket,
                          textAlign: TextAlign.right,
                          maxLinesTextFormField: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        color: ColorManager.white,
        margin: const EdgeInsets.fromLTRB(
            AppMargin.m56, AppMargin.m40, AppMargin.m56, AppMargin.m0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('پشتیبانی', style: getBoldStyle(
                color: ColorManager.black, fontSize: AppSize.s32)),
            const SizedBox(height: AppSize.s24),
            HeaderBar(
              visible: true,
              textFieldController: logic.txtSearchTickets,
              icon: Icons.person_outline,
              nameBtn: 'افزودن تیکت',
              onPress: () {
                // logic.createTicketScreenLogic.listCategory(context: context);
                logic.dialogMainCategoryList(context);
              },
              onChanged: (val) {
                logic.searchTickets(val);
              },
            ),
            const SizedBox(height: AppSize.s24),
            Obx(() {
              if (logic.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: logic.tickets.length,
                  itemBuilder: (context, index) {
                    final ticket = logic.tickets[index];
                    DateTime dateTime = DateTime.parse(
                        ticket.createdAt.toString());
                    Jalali jalaliDate = Jalali.fromDateTime(dateTime);
                    return InkWell(
                        onTap: !ticket.isResolved ?
                            () {
                          logic.ticketsChatList.clear();
                          logic.nameTicket.value = ticket.title;
                          logic.idTicket.value = ticket.id;
                          logic.listChatTicket(context: context,id: ticket.id);
                          logic.scaffoldPanelKey.currentState?.openEndDrawer();
                        } : null,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: ColorManager.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppSize.s8)),
                              ),
                              padding: const EdgeInsets.all(AppPadding.p24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('${index + 1}', style: getMediumStyle(
                                      color: ColorManager.black.withOpacity(
                                          0.6), fontSize: AppSize.s14),
                                    textAlign: TextAlign.start,),
                                  const SizedBox(width: AppSize.s16),
                                  Expanded(child: Text(
                                    'موضوع : ${ticket.title}',
                                    style: getMediumStyle(
                                        color: ColorManager.black,
                                        fontSize: AppSize.s14),
                                    textAlign: TextAlign.start,),),
                                  const SizedBox(width: AppSize.s16),
                                  Expanded(flex: 2,
                                    child: Text(
                                      'توضیحات : ${ticket.description}',
                                      style: getMediumStyle(
                                          color: ColorManager.black,
                                          fontSize: AppSize.s14),
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.clip,),),
                                  const SizedBox(width: AppSize.s16),
                                  Expanded(child: Text(
                                    'تاریخ : ${jalaliDate.year}/${jalaliDate
                                        .month}/${jalaliDate.day}',
                                    style: getMediumStyle(
                                        color: ColorManager.black.withOpacity(
                                            0.6), fontSize: AppSize.s14),
                                    textAlign: TextAlign.start,),),
                                  const SizedBox(width: AppSize.s16),
                                  !ticket.isResolved ?
                                  Text('در حال پیگیری', style: getMediumStyle(
                                      color: ColorManager.yellow,
                                      fontSize: AppSize.s14),
                                    textAlign: TextAlign.start,) :
                                  Text('بسته شده', style: getMediumStyle(
                                      color: ColorManager.green,
                                      fontSize: AppSize.s14),
                                    textAlign: TextAlign.start,),
                                ],
                              ),
                            ),
                            Divider(indent: AppSize.s40,
                                endIndent: AppSize.s40,
                                height: AppSize.s1,
                                color: ColorManager.gray1)
                          ],
                        )
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
