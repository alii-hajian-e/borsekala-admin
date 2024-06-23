// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/value_manager.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Center(
        child: Text('هیچ صفحه ای یافت نشد !',style: getBoldStyle(color: ColorManager.gray1,fontSize: AppSize.s18)),
      ),
    );
  }
}
