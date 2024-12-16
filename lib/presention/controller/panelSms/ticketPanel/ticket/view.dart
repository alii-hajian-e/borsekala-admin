import 'package:bors_web_admin_sms/presention/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../component/header_component/header_component.dart';
import '../../../../resources/styles_manager.dart';
import '../../../../resources/value_manager.dart';
import '../create_ticket_screen/view.dart';
import '../ticket_detail_screen/view.dart';
import 'logic.dart';

class TicketPage extends StatelessWidget {
  TicketPage({super.key});

  final logic = Get.put(TicketLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: ColorManager.white,
        margin: const EdgeInsets.fromLTRB(AppMargin.m56, AppMargin.m40, AppMargin.m56, AppMargin.m0),
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
                    DateTime dateTime = DateTime.parse(ticket.createdAt.toString());
                    Jalali jalaliDate = Jalali.fromDateTime(dateTime);
                    return InkWell(
                        onTap: !ticket.isResolved ?
                            (){
                          GoRouter.of(context).go('/ticketDetailScreenPage');
                        } : null,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                            ),
                            padding: const EdgeInsets.all(AppPadding.p24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${index + 1}' , style: getMediumStyle(color: ColorManager.black.withOpacity(0.6),fontSize: AppSize.s14),textAlign: TextAlign.start,),
                                const SizedBox(width: AppSize.s16),
                                Expanded(child: Text('موضوع : ${ticket.title}',style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14),textAlign: TextAlign.start,),),
                                const SizedBox(width: AppSize.s16),
                                Expanded(flex: 2,child: Text('توضیحات : ${ticket.description}',style: getMediumStyle(color: ColorManager.black,fontSize: AppSize.s14),textAlign: TextAlign.start,overflow: TextOverflow.clip,),),
                                const SizedBox(width: AppSize.s16),
                                Expanded(child: Text('تاریخ : ${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}',style: getMediumStyle(color: ColorManager.black.withOpacity(0.6),fontSize: AppSize.s14),textAlign: TextAlign.start,),),
                                const SizedBox(width: AppSize.s16),
                                !ticket.isResolved ?
                                Text('در حال پیگیری',style: getMediumStyle(color: ColorManager.yellow,fontSize: AppSize.s14),textAlign: TextAlign.start,) :
                                Text('بسته شده',style: getMediumStyle(color: ColorManager.green,fontSize: AppSize.s14),textAlign: TextAlign.start,),
                              ],
                            ),
                          ),
                          Divider(indent: AppSize.s40 ,endIndent: AppSize.s40 ,height: AppSize.s1 ,color: ColorManager.gray1)
                        ],
                      )
                    );
                  },
                ),
              );
            }),
          ],
        ),
      )
    );
  }
}
