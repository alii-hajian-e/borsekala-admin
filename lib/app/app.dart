
// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../presention/resources/routes_manager.dart';
import '../presention/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();
  int appState = 0;
  static final MyApp internal = MyApp._internal();
  factory MyApp() => internal;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
      localizationsDelegates: const [GlobalCupertinoLocalizations.delegate,GlobalMaterialLocalizations.delegate,GlobalWidgetsLocalizations.delegate],
      supportedLocales: const [Locale("fa", "IR")],
      locale: const Locale("fa", "IR"),
      debugShowCheckedModeBanner: false,
      // routeInformationParser: RouteGenerator().router.routeInformationParser,
      // routerDelegate: RouteGenerator().router.routerDelegate,
      // routeInformationProvider: RouteGenerator().router.routeInformationProvider,
      routerConfig: RouteGenerator().router,
      // onGenerateRoute: RouteGenerator.getRoute,
      // initialRoute: MyPreferences.getToken().isNotEmpty ? Routes.landingPage : Routes.loginPage,
      theme: getApplicationTheme(),
    );
  }

}
class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.stylus,
    PointerDeviceKind.trackpad,
  };
}
