import 'package:go_router/go_router.dart';

import '../controller/errorePage.dart';
import '../controller/landing/view.dart';
import '../controller/login/view.dart';
import '../controller/navbar/view.dart';


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
          path: '/navbarPage',
          builder : (context, state) => NavbarPage()
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage()
  );
}
//   static Route<dynamic> getRoute(RouteSettings routeSettings){
//     switch(routeSettings.name){
//       case Routes.navbarPage :
//         return MaterialPageRoute(builder: (_) =>  NavbarPage());
//       case Routes.loginPage :
//         return MaterialPageRoute(builder: (_) =>  LoginPage());
//       case Routes.landingPage :
//         return MaterialPageRoute(builder: (_) =>  LandingPage());
//       default:
//         return unDefinedRout();
//     }
//   }
//   static Route<dynamic> unDefinedRout(){
//     return MaterialPageRoute(builder: (_) => Scaffold(
//       appBar: AppBar(
//         title: const Text(AppString.noRouteFound),
//       ),
//       body: const Center(
//         child: Text(AppString.noRouteFound),
//       ),
//     ));
//   }
// }













