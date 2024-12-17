import 'package:bors_web_admin_sms/presention/controller/panelSetting/navbarSetting/view.dart';
import 'package:go_router/go_router.dart';

import '../controller/errorePage.dart';
import '../controller/landing/view.dart';
import '../controller/login/view.dart';
import '../controller/panelSetting/dayGroup/view.dart';
import '../controller/panelSetting/timeGroup/view.dart';
import '../controller/panelSms/navbarPanel/view.dart';


class RouteGenerator {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder : (context, state) => LoginPage()
      ),
      GoRoute(
          path: '/landingPage',
          builder : (context, state) => LandingPage()
      ),
      GoRoute(
          path: '/navbarPanelPage',
          builder : (context, state) => NavbarPanelPage()
      ),
      GoRoute(
          path: '/navbarSettingPage',
          builder : (context, state) => NavbarSettingPage()
      ),
      GoRoute(
          path: '/timeGroupPage',
          builder : (context, state) => TimeGroupPage()
      ),
      GoRoute(
          path: '/dayGroupPage',
          builder : (context, state) => DayGroupPage()
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage()
  );
}












